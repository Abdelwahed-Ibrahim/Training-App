import 'package:flutter/material.dart';

class DefaultRadioListTile<Type> extends StatelessWidget {
  const DefaultRadioListTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final Type value;
  final Type? groupValue;
  final void Function(Type?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RadioListTile<Type>(
        visualDensity: const VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity,
        ),
        contentPadding: const EdgeInsets.all(0.0),
        title: Text(title),
        value: value,
        activeColor: Colors.redAccent,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
