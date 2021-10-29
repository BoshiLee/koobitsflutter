import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:koobitsflutter/exception/app_exception.dart';
import 'package:koobitsflutter/model/answer.dart';
import 'package:koobitsflutter/model/question.dart';
import 'package:koobitsflutter/repository/topic_repository.dart';

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  final TopicRepository _repository = TopicRepository();
  List<Question> questions = [];
  Map<int, Answer?> answers = {};

  TopicCubit() : super(TopicInitial()) {
    _getQuestions();
  }

  int _currentIndex = 0;

  bool get validate {
    if (answers[_currentIndex] == null) {
      return true;
    } else {
      return (currentAnswerValue != null && currentAnswerValue!.isNotEmpty);
    }
  }

  bool get isFinished =>
      questions.isNotEmpty &&
      (answers.length == questions.length) &&
      _currentIndex == answers.length - 1;

  String get nextStepTitle => isFinished ? '上傳答案' : '下一題';

  Question? get currentQuestion {
    if (questions.isEmpty) return null;
    return questions[_currentIndex];
  }

  Answer? get currentAnswer {
    if (answers[_currentIndex] == null) {
      return null;
    }
    return answers[_currentIndex];
  }

  String? get currentAnswerValue {
    return currentAnswer?.answerString;
  }

  set currentAnswerValue(String? answer) {
    if (answer == null) return;
    if (answer.isEmpty) {
      answers[_currentIndex] = Answer(_currentIndex);
      emit(TopicLoaded());
      return;
    }
    final value = int.parse(answer);
    answers[_currentIndex] = Answer(_currentIndex, answer: value);
    emit(TopicLoaded());
  }

  Future _getQuestions() async {
    try {
      emit(TopicLoading());
      questions = await _repository.getQuestions();
      emit(TopicLoaded());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future submit() async {
    if (currentAnswer == null) {
      emit(const TopicErrorOccurred(errorMessage: '請回答此題'));
      return;
    }
    if (currentAnswer?.answer == null) {
      emit(const TopicErrorOccurred(errorMessage: '請回答此題'));
      return;
    }
    if (!isFinished) {
      _currentIndex += 1;
      emit(NextTopic());
      return;
    }
    try {
      emit(TopicLoading());
      List<Answer> ans = [];
      for (Answer? element in answers.values) {
        if (element != null) ans.add(element);
      }
      await _repository.postAnswers(
        questions: questions,
        answers: ans,
      );
      emit(TopicLoaded());
    } catch (e) {
      if (e is BadDataException) {
        emit(TopicErrorOccurred(errorMessage: e.toString()));
      } else {
        debugPrint(e.toString());
      }
    }
  }
}
