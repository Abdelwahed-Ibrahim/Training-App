import 'package:flutter/material.dart';

import '../styles/styles.dart';

class RoundedRectangleInkWell extends StatelessWidget {
  const RoundedRectangleInkWell({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0, left: 8.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Colors.redAccent),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: kStyleRedAccentNormal16,
          ),
        ),
      ),
    );
  }
}
