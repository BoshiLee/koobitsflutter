import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koobitsflutter/cubits/topic/topic_cubit.dart';
import 'package:koobitsflutter/screens/question_content.dart';
import 'package:koobitsflutter/widgets/scrollable_content_step.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '加法',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: BlocListener<TopicCubit, TopicState>(
        listener: (context, state) {
          if (state is TopicErrorOccurred) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
            ));
          }
        },
        child: BlocBuilder<TopicCubit, TopicState>(
          builder: (context, state) {
            return ScrollableContentStep(
              keepState: false,
              child: QuestionContent(
                validate: context.watch<TopicCubit>().validate,
                initValue: context.read<TopicCubit>().currentAnswerValue,
                isLoading: state is TopicLoading,
                question: context.watch<TopicCubit>().currentQuestion,
                onAnswerChanged: (text) =>
                    context.read<TopicCubit>().currentAnswerValue = text,
              ),
              enableNext: state is! TopicLoading,
              nextStepTitle: context.watch<TopicCubit>().nextStepTitle,
              onNextTap: context.read<TopicCubit>().submit,
            );
          },
        ),
      ),
    );
  }
}
