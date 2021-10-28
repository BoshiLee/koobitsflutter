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
