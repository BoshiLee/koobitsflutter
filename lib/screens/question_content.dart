import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koobitsflutter/model/question.dart';
import 'package:koobitsflutter/styles/text_styles.dart';

class QuestionContent extends StatelessWidget {
  final String? initValue;
  final bool enable;
  final bool isLoading;
  final Question? question;
  final bool validate;
  final String? errorMessage;
  final ValueChanged<String> onAnswerChanged;

  const QuestionContent({
    Key? key,
    this.enable = true,
    this.isLoading = false,
    this.validate = true,
    this.initValue,
    this.errorMessage,
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
            children: [
              Expanded(child: Container()),
              Text(
                isLoading ? '讀取題目中' : '第 ${(question?.id ?? 0) + 1} 題',
                style: kBody.apply(color: Colors.black),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  isLoading ? '題目讀取中' : question?.question ?? '題目取得失敗',
                  style: kBody.apply(color: Colors.black),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    enabled: !isLoading && enable,
                    controller: TextEditingController(text: initValue),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(bottom: 4),
                      hintText: '請輸入數字',
                      hintStyle: kSmall1,
                      errorText: !validate ? errorMessage ?? '此欄位不得為空' : null,
                    ),
                    onSubmitted: onAnswerChanged,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
