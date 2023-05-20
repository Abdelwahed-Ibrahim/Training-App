import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class RoundedTextFieldShadowBelow extends StatelessWidget {
  const RoundedTextFieldShadowBelow({
    super.key,
    required this.keyboardType,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
  });

  final TextInputType keyboardType;
  final String hintText;
  final Icon? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1.3,
      shadowColor: kColorGrey300,
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.all(
        Radius.circular(25.0),
      ),
      type: MaterialType.canvas,
      child: SizedBox(
        height: 40.0,
        child: TextField(
          style: kStyleBlackNormal14,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: kStyleBlackNormal14.copyWith(color: kColorGrey400),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(color: kColorGrey100!),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kColorGrey100!),
                borderRadius: const BorderRadius.all(Radius.circular(25.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kColorGrey100!),
                borderRadius: const BorderRadius.all(Radius.circular(25.0))),
          ),
          obscureText: obscureText,
        ),
      ),
    );
  }
}
