import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/company_layout/cubit/cubit.dart';
import '../../layout/company_layout/cubit/states.dart';
import '../../models/comment_notification.dart';
import '../../models/enroll_request_notification.dart';
import '../../shared/components/notification_widget.dart';
import '../../shared/styles/colors.dart';

class CompanyNotificationScreen extends StatelessWidget {
  const CompanyNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<CompanyCubit, LayoutStates>(
        listener: (context, state) {
          if (state is AddStudentToATrainingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          }
        },
        builder: (context, state) {
          CompanyCubit cubit = CompanyCubit.get(context);
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                (cubit.notification[index] is CommentNotification)
                    ? CommentNotificationWidget(
                        notification:
                            cubit.notification[index] as CommentNotification,
                      )
                    : EnrollTrainingNotificationWidget(
                        notification: cubit.notification[index]
                            as EnrollRequestNotification,
                      ),
            separatorBuilder: (context, index) => separator(),
            itemCount: cubit.notification.length,
          );
        },
      ),
    );
  }

  Widget separator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      color: kColorGrey300,
      width: double.infinity,
      height: .5,
    );
  }
}
