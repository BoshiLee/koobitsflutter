import 'package:koobitsflutter/model/answer.dart';

class Question {
  int? id;
  String? question;
  int? difficulty;
  Answer? answer;

  Question(this.id, {this.question, this.difficulty, this.answer});
}
