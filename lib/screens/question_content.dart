import 'package:flutter/material.dart';
import 'package:koobitsflutter/model/question.dart';
import 'package:koobitsflutter/styles/text_styles.dart';

class QuestionContent extends StatelessWidget {
  final bool isLoading;
  final Question? question;
  final ValueChanged<String> onAnswerChanged;

  const QuestionContent({
    Key? key,
    this.isLoading = false,
    required this.question,
    required this.onAnswerChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Container()),
              Text(
                isLoading ? '讀取題目中' : '第 ${(question?.id ?? 0) + 1} 題',
                style: kBodyRegular.apply(color: Colors.black),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '難度: ${question?.difficulty}',
                  style: kSmall2,
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                isLoading ? '題目讀取中' : question?.question ?? '題目取得失敗',
                style: kSmall1.apply(color: Colors.black),
              ),
              Expanded(
                child: TextField(
                  onChanged: onAnswerChanged,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
