import 'package:flutter/material.dart';

import 'loading_widget.dart';

void navigateAndFinish(BuildContext context, Widget screen) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false,
    );

void navigateTo(BuildContext context, Widget screen) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );

Widget loading() => const LoadingWidget(
      label: 'wait while connecting database',
    );
