import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../layout/company_layout/cubit/cubit.dart';
import '../../layout/student_layout/cubit/cubit.dart';
import '../../models/training_model.dart';
import '../../modules/post_screen/post_screen.dart';
import '../constants.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';
import 'comment_text_field.dart';
import 'components.dart';
import 'default_divider.dart';
import 'default_icon_button.dart';
import 'hash_tag_widget.dart';
import 'post_image.dart';
import 'rounded_icon_button.dart';
import 'write_submit_text_field.dart';

class TrainingPostWidget extends StatelessWidget {
  const TrainingPostWidget({
    super.key,
    required this.post,
  });

  final TrainingPostModel post;

  @override
  Widget build(BuildContext context) {
    Cubit myCubit;
    if (isCompany == true) {
      myCubit = CompanyCubit.get(context);
    } else {
      myCubit = StudentCubit.get(context);
    }
    return GestureDetector(
      onTap: () {
        navigateTo(context, PostScreen(post: post));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPostHeader(
                companyName: post.companyName,
                companyProfileImage: post.companyProfileImage,
                date: post.trainingPostDate,
                isVerifiedCompany: post.isVerifiedCompany,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                post.trainingTitle,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: kStyleBlackNormal14,
              ),
              Wrap(
                children: [
                  for (var tag in post.tags) HashTagWidget(tag: tag),
                ],
              ),
              PostImage(imageLink: post.trainingImage),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    children: [
                      if (isCompany == false)
                        RoundedIconButton(
                          icon: (myCubit as StudentCubit)
                                      .trainingStatus[post.id] ==
                                  TrainingStatus.NonDetermined
                              ? Icons.person_add
                              : (myCubit).trainingStatus[post.id] ==
                                      TrainingStatus.Pending
                                  ? Icons.person_remove
                                  : Icons.person,
                          color: (myCubit).trainingStatus[post.id] ==
                                  TrainingStatus.NonDetermined
                              ? kColorBlack54
                              : (myCubit).trainingStatus[post.id] ==
                                      TrainingStatus.Pending
                                  ? kColorTeal100
                                  : kColorTeal600,
                          label: '${post.requiredStudentNo}',
                          onTap: () {
                            (myCubit as StudentCubit)
                                .requestToEnrollTraining(trainingId: post.id);
                          },
                        ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      RoundedIconButton(
                        icon: Icons.comment,
                        label:
                            '${(myCubit as StudentCubit).commentNo[post.id]}',
                        onTap: () {
                          navigateTo(context, PostScreen(post: post));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const DefaultDivider(),
              buildPostFooter(
                context,
                isCompany == true
                    ? (myCubit as CompanyCubit).company!.avatarUrl!
                    : (myCubit).student!.avatarUrl!,
                isCompany == true
                    ? (myCubit as CompanyCubit).commentController
                    : (myCubit).commentController,
                isCompany == true
                    ? (myCubit as CompanyCubit).writeComment
                    : (myCubit).writeComment,
                post.id,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Padding buildPostFooter(
  BuildContext context,
  String avatarUrl,
  TextEditingController controller,
  void Function({required String trainingId}) commentFunction,
  String postId,
) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          userCircleAvatar(avatarUrl),
          const SizedBox(
            width: 10.0,
          ),
          CommentTextField(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => WriteSubmitTextField(
                  hint: 'Write a public comment...',
                  textController: controller,
                  submitWidget: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: kColorTeal600,
                    ),
                    onPressed: () {
                      commentFunction(trainingId: postId);
                      Navigator.pop(context);
                    },
                  ),
                  isSubmitAllowed: isCompany == true
                      ? CompanyCubit.get(context).isSubmitAllowed
                      : StudentCubit.get(context).isSubmitAllowed,
                  allowSubmitting: isCompany == true
                      ? CompanyCubit.get(context, false).allowSubmitting
                      : StudentCubit.get(context, false).allowSubmitting,
                ),
              );
            },
          ),
        ],
      ),
    );

CircleAvatar userCircleAvatar(String avatarUrl) {
  return CircleAvatar(
    backgroundImage: NetworkImage(avatarUrl),
    backgroundColor: Colors.grey,
  );
}

Row buildPostHeader({
  required String date,
  required String companyName,
  required String companyProfileImage,
  required bool isVerifiedCompany,
}) =>
    Row(
      children: [
        companyCircleAvatar(companyProfileImage),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  companyDetails(companyName, isVerifiedCompany),
                  DefaultIconButton(
                    icon: Icons.more_horiz,
                    onPressed: () {},
                  ),
                  DefaultIconButton(
                    icon: Icons.close,
                    onPressed: () {},
                  ),
                ],
              ),
              Text(
                DateFormat('MMMM d, yyyy At h:mm a')
                    .format(DateTime.parse(date)),
                style: kStyleGreyNormal12,
              )
            ],
          ),
        ))
      ],
    );

Expanded companyDetails(String companyName, bool isVerifiedCompany) {
  return Expanded(
    child: Row(
      children: [
        Text(
          companyName,
          style: kStyleBlackLightBold16,
        ),
        if (isVerifiedCompany) verifiedCompany(),
      ],
    ),
  );
}

Icon verifiedCompany() {
  return const Icon(
    Icons.check_circle_sharp,
    size: 12.0,
    color: Colors.redAccent,
  );
}

CircleAvatar companyCircleAvatar(String companyProfileImage) {
  return CircleAvatar(
    radius: 22.0,
    backgroundImage: NetworkImage(companyProfileImage),
    backgroundColor: Colors.grey,
  );
}
