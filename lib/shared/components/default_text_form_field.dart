import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    this.minLines = 1,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onSuffixPressed,
    this.onTap,
    this.onSubmit,
    this.onSaved,
    this.isPassword = false,
    this.autoFocus = false,
    this.isReadOnly = false,
    this.alignCenter = true,
  });

  final String hintText;
  final int maxLines;
  final int minLines;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final void Function()? onSuffixPressed;
  final void Function()? onTap;
  final void Function(String)? onSubmit;
  final void Function(String?)? onSaved;
  final bool isPassword;
  final bool autoFocus;
  final bool isReadOnly;
  final bool alignCenter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: kStyleBlackLightBold20,
      controller: controller,
      textCapitalization: textCapitalization,
      maxLines: maxLines,
      readOnly: isReadOnly,
      obscureText: isPassword,
      autofocus: autoFocus,
      textInputAction: textInputAction,
      onTap: onTap,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        // const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(3.0)),
        //   borderSide: BorderSide(color: kColorDefault),
        // ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: kColorDefault,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onSuffixPressed,
                icon: Icon(
                  suffixIcon,
                  color: kColorDefault,
                ),
                splashRadius: 15.0,
              )
            : null,
      ),
      textAlign: alignCenter ? TextAlign.center : TextAlign.left,
      validator: validator,
      minLines: minLines,
      onFieldSubmitted: onSubmit,
    );
  }
}
