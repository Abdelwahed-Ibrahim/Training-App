import 'package:flutter/material.dart';

class RoundedMaterialIconButton extends StatelessWidget {
  const RoundedMaterialIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.toUpperCase = true,
  });

  final String label;
  final bool toUpperCase;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
      ),
      height: 40.0,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.redAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              toUpperCase ? label.toUpperCase() : label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
