import 'package:flutter/material.dart';

import '../styles/colors.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = kColorBlack54,
  });

  final IconData icon;
  final String label;
  final void Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: kColorGrey200,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
