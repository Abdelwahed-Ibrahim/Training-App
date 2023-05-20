import 'package:flutter/material.dart';

import '../styles/colors.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      height: 250.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
        color: kColorTeal600,
        boxShadow: [
          BoxShadow(
            color: kColorTeal100!,
            offset: const Offset(0.0, 8.0),
            blurRadius: 0.3,
            spreadRadius: 2.0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Here\'s to your goals',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Check out your latest batch of recommended trainings.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
