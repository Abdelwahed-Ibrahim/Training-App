import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class RectangleInkWell extends StatelessWidget {
  const RectangleInkWell({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: kColorTeal600!,
            width: 2.0,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.5),
            child: Center(
              child: Text(
                label,
                style: kStyleTealBold16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
