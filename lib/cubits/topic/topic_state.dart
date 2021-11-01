part of 'topic_cubit.dart';

abstract class TopicState extends Equatable {
  const TopicState();
}

class TopicInitial extends TopicState {
  @override
  List<Object> get props => [];
}

class TopicLoading extends TopicState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class TopicLoaded extends TopicState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class NextTopic extends TopicState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class PresentResult extends TopicState {
  final TopicResult result;

  const PresentResult(this.result);

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class TopicErrorOccurred extends TopicState {
  final String errorMessage;

  const TopicErrorOccurred({required this.errorMessage});

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}
