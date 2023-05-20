import 'package:flutter/material.dart';

import '../styles/styles.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            label,
            style: kStyleGreyNormal16,
          ),
        ],
      ),
    );
  }
}
