import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../layout/student_layout/cubit/cubit.dart';
import '../../layout/student_layout/cubit/states.dart';
import '../../models/enrollment_notification.dart';
import '../../models/training_model.dart';
import '../../models/uploaded_training_notification.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/styles.dart';
import '../post_screen/post_screen.dart';
import '../profile_screen/profile_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<StudentCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          StudentCubit cubit = StudentCubit.get(context);
          return cubit.notifications.isEmpty
              ? const Center(
                  child: Text('No Notification Yet'),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      cubit.notifications[index] is UploadedTrainingNotification
                          ? NewTrainingNotification(
                              notification: cubit.notifications[index]
                                  as UploadedTrainingNotification,
                            )
                          : EnrollmentTrainingNotification(
                              notification: cubit.notifications[index]
                                  as EnrollmentNotification,
                            ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
                  itemCount: cubit.notifications.length,
                );
        },
      ),
    );
  }
}

class NewTrainingNotification extends StatelessWidget {
  const NewTrainingNotification({
    Key? key,
    required this.notification,
  }) : super(key: key);
  final UploadedTrainingNotification notification;

  @override
  Widget build(BuildContext context) {
    TrainingPostModel post = StudentCubit.get(context)
        .trainings
        .firstWhere((training) => training.id == notification.trainingId);
    return Container(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          navigateTo(context, PostScreen(post: post));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${notification.companyName} Posted: ',
                      style: kStyleBlackLightBold14,
                    ),
                    Text(
                      notification.trainingTitle,
                      style: kStyleBlackNormal14,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 2,
                    ),
                    Text(
                      DateFormat('MMMM d, yyyy At h:mm a')
                          .format(DateTime.parse(notification.dateTime)),
                      style: kStyleGreyNormal12,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 4.0,
              ),
              SizedBox(
                width: 120,
                height: 60,
                child: Image(
                  image: NetworkImage(notification.trainingImage),
                  height: 60.0,
                  width: 120.0,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Congrats DeepBlue Company just added you to a training The Complete 2023 Web Development Bootcamp
class EnrollmentTrainingNotification extends StatelessWidget {
  const EnrollmentTrainingNotification({
    Key? key,
    required this.notification,
  }) : super(key: key);
  final EnrollmentNotification notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          navigateTo(context, ProfileScreen(uId: notification.companyId));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Congrats ',
                          ),
                          TextSpan(
                            text: notification.companyName.length > 18
                                ? '${notification.companyName.substring(0, 18)}...'
                                : notification.companyName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(
                            text: ' just added you to a training: ',
                          ),
                          TextSpan(
                            text: notification.trainingTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      DateFormat('MMMM d, yyyy At h:mm a')
                          .format(DateTime.parse(notification.dateTime)),
                      style: kStyleGreyNormal12,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 4.0,
              ),
              SizedBox(
                width: 120,
                height: 60,
                child: Image(
                  image: NetworkImage(notification.trainingImage),
                  height: 60.0,
                  width: 120.0,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
