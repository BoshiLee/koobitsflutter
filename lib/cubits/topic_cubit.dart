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

  TopicCubit() : super(TopicInitial());

  Future getQuestions() async {
    try {
      emit(TopicLoading());
      questions = await _repository.getQuestions();
      emit(TopicLoaded());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
