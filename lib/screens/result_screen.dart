import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koobitsflutter/cubits/result/topic_result_cubit.dart';
import 'package:koobitsflutter/screens/question_content.dart';
import 'package:koobitsflutter/styles/text_styles.dart';

class ResultScreen extends StatelessWidget {
  static String id = 'ResultScreen';

  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicResultCubit, TopicResultState>(
        builder: (context, state) {
      if (state is TopicResultErrorOccurred) {
        return Column(
          children: [
            Text(
              state.errorMessage,
              style: kBody.apply(
                color: Colors.redAccent[300],
              ),
            ),
          ],
        );
      }
      if (state is TopicResultAllCorrect) {
        return Column(
          children: [
            Text(
              state.message,
              style: kBody.apply(
                color: Colors.greenAccent[300],
              ),
            ),
          ],
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            '結果',
            style: kBody,
          ),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            final question =
                context.watch<TopicResultCubit>().questionMap[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuestionContent(
                    question: question,
                    initValue: context
                        .watch<TopicResultCubit>()
                        .questionMap[index]
                        ?.answer
                        ?.answerString,
                    onAnswerChanged: (_) {},
                  ),
                  Text(
                    '你的答案為 ${question?.answer?.answerString}',
                    style: TextStyle(color: Colors.red[300]),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 1,
              color: Colors.grey[800],
            ),
          ),
          itemCount: context.watch<TopicResultCubit>().questionMap.length,
        ),
      );
    });
  }
}
