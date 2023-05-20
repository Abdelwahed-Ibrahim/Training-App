import 'package:flutter/material.dart';

import '../styles/styles.dart';

class CheckListItem extends StatelessWidget {
  const CheckListItem({
    super.key,
    required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_rounded,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
              child: Text(
            item,
            style: kStyleBlackLightBold18,
          ))
        ],
      ),
    );
  }
}
