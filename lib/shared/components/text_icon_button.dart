import 'package:flutter/material.dart';

import '../styles/styles.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.margin,
  });

  final Icon icon;
  final String label;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        onPressed: onPressed,
        icon: icon,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              label,
              style: kStyleBlackNormal18,
            ),
          ],
        ),
      ),
    );
  }
}
