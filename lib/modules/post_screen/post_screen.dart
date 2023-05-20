import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../layout/company_layout/cubit/cubit.dart';
import '../../layout/student_layout/cubit/cubit.dart';
import '../../models/comment_model.dart';
import '../../models/training_model.dart';
import '../../shared/components/check_list_builder.dart';
import '../../shared/components/comment_text_field.dart';
import '../../shared/components/comment_widget.dart';
import '../../shared/components/components.dart';
import '../../shared/components/default_divider.dart';
import '../../shared/components/default_icon_button.dart';
import '../../shared/components/expandable_item_name.dart';
import '../../shared/components/hash_tag_widget.dart';
import '../../shared/components/post_image.dart';
import '../../shared/components/rating_widget.dart';
import '../../shared/components/rounded_material_button.dart';
import '../../shared/components/rounded_material_icon_button.dart';
import '../../shared/components/text_with_icon.dart';
import '../../shared/components/write_submit_text_field.dart';
import '../../shared/constants.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';
import '../profile_screen/profile_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);
  final TrainingPostModel post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit()..getTrainingPostComments(post.id),
      child: BlocConsumer<PostCubit, PostStates>(
        listener: (context, state) {},
        builder: (context, state) {
          PostCubit cubit = PostCubit.get(context);
          Cubit myCubit;
          if (isCompany == true) {
            myCubit = CompanyCubit.get(context);
          } else {
            myCubit = StudentCubit.get(context);
          }
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          DefaultIconButton(
                            icon: Icons.arrow_back_ios_new,
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: buildPostHeader(
                              companyName: post.companyName,
                              date: post.trainingPostDate,
                              isVerifiedCompany: post.isVerifiedCompany,
                              companyProfileImage: post.companyProfileImage,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      PostImage(imageLink: post.trainingImage),
                      Text(
                        post.trainingTitle,
                        style: kStyleBlackLightBold28,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Wrap(
                        children: [
                          for (var tag in post.tags) HashTagWidget(tag: tag),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          RatingWidget(
                            initialRating: post.rating,
                            totalNumber: post.ratingStudent,
                          ),
                          const Expanded(
                            child: SizedBox(
                              width: 1.0,
                            ),
                          ),
                        ],
                      ),
                      TextWithIcon(
                        icon: Icons.person,
                        text: '${post.requiredStudentNo} Required Student.',
                      ),
                      TextWithIcon(
                        icon: Icons.calendar_month,
                        text: 'Start at ${post.startingDate}.',
                      ),
                      TextWithIcon(
                        icon: Icons.watch_later_outlined,
                        text:
                            '(${post.totalHours} hours) Total, ${post.hoursPerWeek} hours per week.',
                      ),
                      const DefaultDivider(),
                      CheckListBuilder(
                        listName: 'What you\'ll learn',
                        list: post.learnedTitles,
                        icon: cubit.learnedTitlesIcon,
                        isExpanded: cubit.expandLearnedTitles,
                        onPressed: cubit.changeLearnedTitleVisibility,
                      ),
                      const DefaultDivider(),
                      ExpandableItemName(
                        titleName: 'Description',
                        icon: cubit.descriptionIcon,
                        onPressed: cubit.changeDescriptionVisibility,
                      ),
                      if (cubit.expandDescription)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            post.description,
                            style: kStyleBlackLightBold18,
                          ),
                        ),
                      const DefaultDivider(),
                      buildPostFooter(
                        context,
                        isCompany == true
                            ? (myCubit as CompanyCubit).company!.avatarUrl!
                            : (myCubit as StudentCubit).student!.avatarUrl!,
                        isCompany == true
                            ? (myCubit as CompanyCubit).commentController
                            : (myCubit as StudentCubit).commentController,
                        isCompany == true
                            ? (myCubit as CompanyCubit).writeComment
                            : (myCubit as StudentCubit).writeComment,
                        post.id,
                      ),
                      commentsBuilder(comments: cubit.comments),
                      const DefaultDivider(),
                      if (isCompany == false &&
                          (myCubit as StudentCubit).trainingStatus[post.id] ==
                              TrainingStatus.Enrolled)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: double.infinity,
                          child: RoundedMaterialButton(
                            onPressed: () {
                              navigateTo(
                                  context, ProfileScreen(uId: post.companyId));
                            },
                            label: 'View Company Profile',
                          ),
                        ),
                      if (isCompany == false &&
                          (myCubit as StudentCubit).trainingStatus[post.id] !=
                              TrainingStatus.Enrolled)
                        RoundedMaterialIconButton(
                          label: myCubit.trainingStatus[post.id] ==
                                  TrainingStatus.NonDetermined
                              ? 'enroll now'
                              : 'Cancel request',
                          icon: myCubit.trainingStatus[post.id] ==
                                  TrainingStatus.NonDetermined
                              ? Icons.person_add
                              : Icons.person_remove,
                          // icon: Icons.person_remove,
                          onPressed: () {
                            (myCubit as StudentCubit)
                                .requestToEnrollTraining(trainingId: post.id);
                          },
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget commentsBuilder({required List<CommentModel> comments}) {
    return Column(
      children: [
        const DefaultDivider(),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Comments',
            style: kStyleBlackLightBold28,
          ),
        ),
        if (comments.isEmpty)
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'No Comments yet!',
                style: kStyleBlackLightBold28,
              ),
            ),
          ),
        for (var comment in comments) CommentWidget(comment: comment)
      ],
    );
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

  CircleAvatar userCircleAvatar(String avatarUrl) {
    return CircleAvatar(
      backgroundImage: NetworkImage(avatarUrl),
      backgroundColor: Colors.grey,
    );
  }
}
