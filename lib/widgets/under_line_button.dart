import 'package:flutter/material.dart';

class UnderLineButton extends StatelessWidget {
  final Widget? title;
  final VoidCallback onPressed;
  final Color? borderColor;
  final bool enable;

  const UnderLineButton({
    Key? key,
    this.title,
    this.enable = true,
    required this.onPressed,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enable ? onPressed : () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: borderColor ?? Colors.black,
            ),
          ),
        ),
        child: title,
      ),
    );
  }
}
