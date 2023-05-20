import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../layout/company_layout/cubit/cubit.dart';
import '../../models/comment_notification.dart';
import '../../models/enroll_request_notification.dart';
import '../../models/training_model.dart';
import '../../modules/post_screen/post_screen.dart';
import '../../modules/profile_screen/profile_screen.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';
import 'components.dart';
import 'flat_button_widget.dart';
import 'outlined_button_widget.dart';

class CommentNotificationWidget extends StatelessWidget {
  const CommentNotificationWidget({super.key, required this.notification});

  final CommentNotification notification;

  @override
  Widget build(BuildContext context) {
    TrainingPostModel myPost = CompanyCubit.get(context)
        .trainings
        .firstWhere((training) => training.id == notification.trainingId);
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          navigateTo(context, PostScreen(post: myPost));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 15.0,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          notification.studentAvatarUrl,
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: kColorAmber600,
                        child: const Icon(
                          Icons.message_rounded,
                          color: kColorWhite,
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: notification.studentName.length > 18
                                    ? '${notification.studentName.substring(0, 18)}...'
                                    : notification.studentName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(
                                text: ' commented on your training Post:',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          DateFormat('MMMM d, yyyy At h:mm a')
                              .format(DateTime.parse(notification.dateTime)),
                          style: kStyleGreyNormal12,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    height: 50.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          notification.trainingImage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: OutlinedButtonWidget(
              //         onPressed: () {},
              //         text: 'Show Post',
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10.0,
              //     ),
              //     Expanded(
              //       child: FlatButtonWidget(
              //         onPressed: () {},
              //         text: 'View Profile',
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class EnrollTrainingNotificationWidget extends StatelessWidget {
  const EnrollTrainingNotificationWidget(
      {super.key, required this.notification});

  final EnrollRequestNotification notification;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              ProfileScreen(
                uId: notification.studentId,
                trainingId: notification.trainingId,
                notificationId: notification.notificationId,
              ));
        },
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: kColorGrey300!,
              ),
              borderRadius: BorderRadius.circular(5.0)),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 15.0,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          notification.studentAvatarUrl,
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: kColorTeal600,
                        child: const Icon(
                          Icons.people,
                          color: kColorWhite,
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: notification.studentName.length > 18
                                    ? '${notification.studentName.substring(0, 18)}...'
                                    : notification.studentName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(
                                text: ' Asks to Enroll this Training:',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          DateFormat('MMMM d, yyyy At h:mm a')
                              .format(DateTime.parse(notification.dateTime)),
                          style: kStyleGreyNormal12,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    height: 50.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          notification.trainingImage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButtonWidget(
                      onPressed: () {
                        BlocProvider.of<CompanyCubit>(context, listen: false)
                            .addStudentToTraining(
                          notificationId: notification.notificationId,
                          trainingId: notification.trainingId,
                          studentId: notification.studentId,
                        );
                      },
                      text: 'Add',
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: FlatButtonWidget(
                      onPressed: () {
                        BlocProvider.of<CompanyCubit>(context, listen: false)
                            .removeRequestStudentToTraining(
                          notificationId: notification.notificationId,
                          trainingId: notification.trainingId,
                          studentId: notification.studentId,
                        );
                      },
                      text: 'Remove',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
