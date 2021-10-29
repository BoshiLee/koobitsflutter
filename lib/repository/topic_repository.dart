import 'package:koobitsflutter/exception/app_exception.dart';
import 'package:koobitsflutter/model/answer.dart';
import 'package:koobitsflutter/model/question.dart';

class TopicRepository {
  Future<List<Question>> getQuestions() async {
    List<Question> questions = [];
    await Future.delayed(
      const Duration(seconds: 1),
    );
    for (var i = 0; i < 10; i++) {
      questions.add(
        Question(
          i,
          question: '1 + $i =',
          difficulty: 5,
          answer: Answer(i, answer: 1 + i),
        ),
      );
    }
    return questions;
  }

  Future<List<Answer>> postAnswers(
      {required List<Question> questions,
      required List<Answer> answers}) async {
    final answerMap = answers.asMap();
    List<Answer> wrongAns = [];
    for (Question question in questions) {
      if (!answerMap.containsKey(question.id))
        throw BadDataException('第 ${question.id} 尚未回答');
      if (answerMap[question.id]?.answer != question.answer?.answer) {
        wrongAns.add(question.answer ?? Answer(question.id));
      }
    }
    return wrongAns;
  }
}
