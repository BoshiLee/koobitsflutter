import 'package:flutter/material.dart';
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
      body: ScrollableContentStep(
        child: Container(),
      ),
    );
  }
}
