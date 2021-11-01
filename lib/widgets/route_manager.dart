import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koobitsflutter/cubits/result/topic_result_cubit.dart';
import 'package:koobitsflutter/model/topic_result.dart';
import 'package:koobitsflutter/screens/result_screen.dart';

extension BSNavigator on Navigator {
  static Future<T?> navigateToNextPage<T extends Object?>(
    BuildContext context,
    Widget page,
    String pageId, {
    bool fullscreenDialog = false,
  }) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: pageId),
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static void popToRoot(BuildContext context) {
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
  }

  static void popToPrevious(BuildContext context, String pageId) {
    Navigator.popUntil(context, ModalRoute.withName(pageId));
  }
}

class RouteManager {
  static navigateToResultScreen(BuildContext context,
      {required TopicResult result}) {
    BSNavigator.navigateToNextPage(
      context,
      BlocProvider(
        create: (context) => TopicResultCubit(result),
        child: const ResultScreen(),
      ),
      ResultScreen.id,
    );
  }
}
