import 'package:flutter/material.dart';

class DefaultIconButton extends StatelessWidget {
  const DefaultIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = Colors.grey,
  });

  final IconData icon;
  final void Function()? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints(
        maxWidth: 30.0,
        maxHeight: 30.0,
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 20.0,
        color: color,
      ),
      splashRadius: 15.0,
      padding: EdgeInsets.zero,
    );
  }
}
