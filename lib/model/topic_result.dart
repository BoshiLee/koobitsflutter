import 'package:koobitsflutter/model/answer.dart';
import 'package:koobitsflutter/model/question.dart';

class TopicResult {
  final List<Question> questions;
  final List<Answer> answer;

  TopicResult({
    this.questions = const [],
    this.answer = const [],
  });
}
