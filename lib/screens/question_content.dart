import 'package:flutter/material.dart';
import 'package:koobitsflutter/model/question.dart';
import 'package:koobitsflutter/styles/text_styles.dart';

class QuestionContent extends StatelessWidget {
  final Question question;
  final ValueChanged<String> onAnswerChanged;

  const QuestionContent({
    Key? key,
    required this.question,
    required this.onAnswerChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Container()),
            Text(
              '第 ${question.id} 題',
              style: kBodyRegular.apply(color: Colors.black),
            ),
            Expanded(child: Text('難度: ${question.difficulty}'))
          ],
        ),
        Row(
          children: [
            Text(
              question.question ?? '題目取得失敗',
              style: kSmall1.apply(color: Colors.black),
            ),
            TextField(
              onChanged: onAnswerChanged,
            ),
          ],
        )
      ],
    );
  }
}
