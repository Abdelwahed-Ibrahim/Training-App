import 'package:flutter/material.dart';

import '../../models/training_model.dart';
import '../../modules/post_screen/post_screen.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';
import 'components.dart';
import 'rating_widget.dart';
import 'training_post_widget.dart';

class TrainingWidget extends StatelessWidget {
  const TrainingWidget({
    super.key,
    required this.post,
  });

  final TrainingPostModel post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, PostScreen(post: post));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 15.0),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: kColorGrey100),
        // width: 240.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
              height: 200,
              clipBehavior: Clip.antiAlias,
              child: Image(
                image: NetworkImage(post.trainingImage),
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(post.companyProfileImage),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          post.trainingTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kStyleBlackLightBold18,
                        ),
                        Row(
                          children: [
                            Text(
                              post.companyName,
                              style: kStyleGreyNormal16.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                            if (post.isVerifiedCompany) verifiedCompany(),
                          ],
                        ),
                        Row(
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
                        const SizedBox(height: 5.0),
                        RatingWidget(
                          initialRating: post.rating,
                          totalNumber: post.ratingStudent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
