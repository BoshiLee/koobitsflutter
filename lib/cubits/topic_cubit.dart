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
  List<Answer> answers = [];

  TopicCubit() : super(TopicInitial()) {
    _getQuestions();
  }

  int _currentIndex = 0;

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
    if (answers.isEmpty) return null;
    return answers[_currentIndex];
  }

  String? get currentAnswerValue {
    return currentAnswer?.answerString;
  }

  set currentAnswerValue(String? answer) {
    if (answer == null) return;
    if (answer.isEmpty) return;
    final value = int.parse(answer);
    _insetNewAnswer(Answer(_currentIndex, answer: value));
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

  _insetNewAnswer(Answer answer) {
    Map ansMap = answers.asMap();
    if (ansMap.containsKey(answer.id)) {
      answers[answer.id!] = answer;
    } else {
      answers.add(answer);
    }
  }

  Future submit() async {
    if (currentAnswer == null) {
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
      await _repository.postAnswers(
        questions: questions,
        answers: answers,
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
