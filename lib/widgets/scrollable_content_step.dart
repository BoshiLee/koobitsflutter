import 'dart:math';

import 'package:flutter/material.dart';

import 'under_line_button.dart';

class ScrollableContentStep extends StatelessWidget {
  final Widget child;
  final String? nextStepTitle;
  final VoidCallback? onNextTap;
  final bool enableNext;
  final bool expandContent;
  final ScrollPhysics? scrollPhysics;
  final bool keepState;

  const ScrollableContentStep({
    Key? key,
    required this.child,
    this.scrollPhysics,
    this.enableNext = true,
    this.nextStepTitle,
    this.onNextTap,
    this.expandContent = true,
    this.keepState = true,
  }) : super(key: key);

  _hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _hideKeyboard(context),
      onVerticalDragDown: (_) => _hideKeyboard(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              key: keepState
                  ? null
                  : ValueKey<int>(Random(DateTime.now().millisecondsSinceEpoch)
                      .nextInt(4294967296)),
              physics: scrollPhysics ?? const NeverScrollableScrollPhysics(),
              child: expandContent ? child : child,
              padding: const EdgeInsets.only(bottom: 40),
            ),
          ),
          onNextTap != null
              ? SafeArea(
                  child: UnderLineButton(
                    enable: enableNext,
                    title: Text(
                      nextStepTitle ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => onNextTap?.call(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
