import 'package:flutter/material.dart';

import '../styles/styles.dart';
import 'default_icon_button.dart';

class ExpandableItemName extends StatelessWidget {
  const ExpandableItemName({
    super.key,
    required this.titleName,
    required this.icon,
    required this.onPressed,
  });

  final String titleName;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleName,
            style: kStyleBlackLightBold28,
          ),
          DefaultIconButton(
            icon: icon,
            onPressed: onPressed,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
