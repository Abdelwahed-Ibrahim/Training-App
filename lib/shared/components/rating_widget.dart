import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    this.initialRating = 0.0,
    this.totalNumber = 0,
  });

  final double initialRating;
  final int totalNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          '$initialRating',
          style: kStyleBlackLightBold16,
        ),
        RatingBar.builder(
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: 18.0,
          initialRating: initialRating,
          unratedColor: kColorAmber100,
          itemCount: 5,
          ignoreGestures: true,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
        Text(
          '($totalNumber ratings)',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
