import 'package:flutter/material.dart';

import '../styles/colors.dart';

class WriteSubmitTextField extends StatelessWidget {
  const WriteSubmitTextField({
    super.key,
    required this.hint,
    required this.isSubmitAllowed,
    required this.allowSubmitting,
    required this.submitWidget,
    required this.textController,
  });

  final String hint;
  final Widget submitWidget;
  final bool isSubmitAllowed;
  final void Function(String) allowSubmitting;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: kColorGrey200,
            ),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: kColorGrey200!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: kColorGrey200!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: kColorGrey200!),
                ),
                contentPadding: const EdgeInsets.all(8.0),
                hintText: hint,
                suffixIcon: isSubmitAllowed ? submitWidget : null,
              ),
              onChanged: allowSubmitting,
              controller: textController,
              autofocus: true,
            ),
          ),
        ),
      ),
    );
  }
}
