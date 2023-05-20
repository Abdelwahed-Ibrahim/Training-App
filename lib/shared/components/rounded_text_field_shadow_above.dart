import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class RoundedTextFieldShadowAbove extends StatelessWidget {
  const RoundedTextFieldShadowAbove({
    super.key,
    required this.keyboardType,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.isAutoFocus = false,
    this.textInputAction = TextInputAction.next,
  });

  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isAutoFocus;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      clipBehavior: Clip.antiAlias,
      // height: 40.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(25.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: kColorGrey300!,
            offset: const Offset(0.0, -1.3),
            blurRadius: 2.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: Material(
        color: Colors.white,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 14.0),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
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
          validator: validator,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          autofocus: isAutoFocus,
          textInputAction: textInputAction,
        ),
      ),
    );
  }
}
