import 'package:flutter/material.dart';

import '../styles/colors.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 35.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: kColorGrey100,
          ),
          child: const Center(
            child: Text(
              'Write a comment ...',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
