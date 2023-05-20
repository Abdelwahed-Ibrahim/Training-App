import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/comment_model.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(comment.userProfileImage),
              backgroundColor: Colors.grey,
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        Text(
                          comment.userName,
                          style:
                              kStyleBlackLightBold16.copyWith(fontSize: 14.0),
                        ),
                        const Icon(
                          Icons.check_circle_sharp,
                          size: 12.0,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: kColorGrey300,
                    ),
                    child: Text(
                      comment.comment,
                      style: kStyleBlackLightBold16,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM d, yyyy At h:mm a')
                        .format(DateTime.parse(comment.commentDateTime)),
                    style: kStyleGreyNormal12,
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
