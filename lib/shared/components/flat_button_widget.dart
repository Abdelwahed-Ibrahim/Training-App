import 'package:flutter/material.dart';

class FlatButtonWidget extends StatelessWidget {
  const FlatButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(Colors.teal),
        overlayColor: MaterialStateProperty.all(
          Colors.white.withOpacity(.2),
        ),
      ),
      child: Text(text),
    );
  }
}
