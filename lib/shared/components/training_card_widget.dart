import 'package:flutter/material.dart';

import '../../models/training_model.dart';
import '../../modules/post_screen/post_screen.dart';
import '../styles/styles.dart';
import 'components.dart';
import 'rating_widget.dart';

class TrainingCardWidget extends StatelessWidget {
  const TrainingCardWidget({
    super.key,
    required this.post,
  });

  final TrainingPostModel post;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.0,
      // width: 240.0,
      child: GestureDetector(
        onTap: () {
          navigateTo(context, PostScreen(post: post));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 145,
                child: Image(
                  image: NetworkImage(post.trainingImage),
                  height: 145,
                  // height: 160,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  post.trainingTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kStyleBlackNormal16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text('(${post.requiredStudentNo}) Students'),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RatingWidget(
                  initialRating: post.rating,
                  totalNumber: post.ratingStudent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
