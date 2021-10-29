import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koobitsflutter/cubits/result/topic_result_cubit.dart';
import 'package:koobitsflutter/screens/question_content.dart';
import 'package:koobitsflutter/styles/text_styles.dart';

class ResultScreen extends StatelessWidget {
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
      return ListView.separated(
        itemBuilder: (context, index) {
          final question = context.watch<TopicResultCubit>().correctMap[index];
          return QuestionContent(
            question: question,
            enable: false,
            validate: false,
            errorMessage: '正確答案為 ${question?.answer?.answerString}',
            initValue:
                context.watch<TopicResultCubit>().wrongMap[index]?.answerString,
            onAnswerChanged: (_) {},
          );
        },
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: Colors.grey[800],
        ),
        itemCount: context.watch<TopicResultCubit>().correctMap.length,
      );
    });
  }
}
