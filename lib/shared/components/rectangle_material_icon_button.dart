import 'package:flutter/material.dart';

class RectangleMaterialIconButton extends StatelessWidget {
  const RectangleMaterialIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(25.0),
      // ),
      height: 60.0,
      width: double.infinity,
      // clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.teal,
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
              label.toUpperCase(),
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
