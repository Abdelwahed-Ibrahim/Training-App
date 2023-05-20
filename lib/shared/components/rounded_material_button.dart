import 'package:flutter/material.dart';

class RoundedMaterialButton extends StatelessWidget {
  const RoundedMaterialButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
      ),
      height: 35.0,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.redAccent,
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
