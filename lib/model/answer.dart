class Answer {
  int? id;
  String? get answerString => answer?.toString();
  int? answer;

  Answer(
    id, {
    this.answer,
  });
}
