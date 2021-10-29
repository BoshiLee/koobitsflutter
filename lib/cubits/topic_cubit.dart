import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
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

  int currentIndex = 0;

  Question? get currentQuestion {
    if (questions.isEmpty) return null;
    return questions[currentIndex];
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

  Future submit(Answer answer) async {
    Map ansMap = answers.asMap();
    if (ansMap.containsKey(answer.id)) {
      answers[answer.id!] = answer;
    } else {
      answers.add(answer);
      currentIndex += 1;
    }
  }
}
