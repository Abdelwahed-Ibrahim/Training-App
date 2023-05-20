import 'package:flutter/material.dart';

import '../styles/styles.dart';

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blueGrey,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
              child: Text(
            text,
            style: kStyleBlackLightBold16,
          ))
        ],
      ),
    );
  }
}
