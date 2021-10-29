import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koobitsflutter/model/question.dart';
import 'package:koobitsflutter/styles/text_styles.dart';

class QuestionContent extends StatefulWidget {
  final String? initValue;
  final bool isLoading;
  final Question? question;
  final ValueChanged<String> onAnswerChanged;

  const QuestionContent({
    Key? key,
    this.isLoading = false,
    this.initValue,
    required this.question,
    required this.onAnswerChanged,
  }) : super(key: key);

  @override
  State<QuestionContent> createState() => _QuestionContentState();
}

class _QuestionContentState extends State<QuestionContent> {
  late String _text;
  bool _validate = false;
  late TextEditingController _controller;

  @override
  void initState() {
    _text = widget.initValue ?? '';
    _controller = TextEditingController(text: widget.initValue);
    _controller.addListener(
      () => setState(() {
        _text = _controller.text;
        _validate = _text.isNotEmpty;
        if (_validate) {
          widget.onAnswerChanged.call(_text);
        }
      }),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                widget.isLoading
                    ? '讀取題目中'
                    : '第 ${(widget.question?.id ?? 0) + 1} 題',
                style: kBodyRegular.apply(color: Colors.black),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '難度: ${widget.question?.difficulty}',
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
                  widget.isLoading
                      ? '題目讀取中'
                      : widget.question?.question ?? '題目取得失敗',
                  style: kBodyRegular.apply(color: Colors.black),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    enabled: !widget.isLoading,
                    controller: _controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(bottom: 4),
                      hintText: '請輸入數字',
                      errorText: !_validate ? '此欄位不得為空' : null,
                    ),
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
