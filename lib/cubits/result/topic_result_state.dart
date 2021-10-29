part of 'topic_result_cubit.dart';

abstract class TopicResultState extends Equatable {
  const TopicResultState();
}

class TopicResultInitial extends TopicResultState {
  @override
  List<Object> get props => [];
}

class TopicResultAllCorrect extends TopicResultState {
  final String message;

  const TopicResultAllCorrect({required this.message});

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class TopicResultErrorOccurred extends TopicResultState {
  final String errorMessage;

  const TopicResultErrorOccurred({required this.errorMessage});

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}
