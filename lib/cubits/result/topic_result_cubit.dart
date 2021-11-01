import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koobitsflutter/model/answer.dart';
import 'package:koobitsflutter/model/question.dart';
import 'package:koobitsflutter/model/topic_result.dart';

part 'topic_result_state.dart';

class TopicResultCubit extends Cubit<TopicResultState> {
  final Map<int, Answer> wrongMap;
  final Map<int, Question> questionMap;

  TopicResultCubit(TopicResult topicResult)
      : wrongMap = topicResult.answer.asMap(),
        questionMap = topicResult.questions.asMap(),
        super(TopicResultInitial()) {
    configStates();
  }

  configStates() {
    if (wrongMap.length != questionMap.length) {
      emit(const TopicResultErrorOccurred(errorMessage: '答案數量不相符'));
      return;
    }
    if (wrongMap.isEmpty && questionMap.isEmpty) {
      emit(const TopicResultAllCorrect(message: '恭喜你! 全都答對了'));
      return;
    }
  }
}
