import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/student_layout/cubit/cubit.dart';
import '../../layout/student_layout/cubit/states.dart';
import '../../models/training_model.dart';
import '../../shared/components/default_text_button.dart';
import '../../shared/components/training_card_widget.dart';
import '../../shared/components/training_post_widget.dart';
import '../../shared/styles/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        StudentCubit cubit = StudentCubit.get(context);
        return cubit.trainings.isEmpty ||
                cubit.trainingStatus.isEmpty ||
                cubit.commentNo.isEmpty ||
                cubit.student == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // bannerBuilder(),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20.0, vertical: 25.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Text(
                    //         'Discover',
                    //         style: kStyleBlackBold30,
                    //       ),
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(
                    //           Icons.search,
                    //           size: 26.0,
                    //         ),
                    //         splashRadius: 20.0,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 330.0,
                        //   child: TabBarView(
                        //       physics: const BouncingScrollPhysics(),
                        //       children: [
                        //         viewTapContent('assets/images/training_7.jpeg',
                        //             'Top trainings'),
                        //         viewTapContent('assets/images/training_8.jpeg',
                        //             'Top ${categories[1].toLowerCase()} trainings'),
                        //         viewTapContent('assets/images/training_1.jpeg',
                        //             'Top ${categories[2].toLowerCase()} trainings'),
                        //         viewTapContent('assets/images/training_2.jpeg',
                        //             'Top ${categories[3].toLowerCase()} trainings'),
                        //         viewTapContent('assets/images/training_3.jpeg',
                        //             'Top ${categories[4].toLowerCase()} trainings'),
                        //       ]),
                        // ),
                        if (cubit.myTrainings.isNotEmpty)
                          myTrainingSection(cubit.myTrainings),
                        // categoriesSection(),
                        trendingTrainingSection(cubit.trainings),
                      ],
                    )
                  ],
                ),
              );
      },
    );
  }
}

Widget myTrainingSection(List<TrainingPostModel> posts) => Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Training',
                style: kStyleBlackLightBold18,
              ),
              BlocConsumer<StudentCubit, AppStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  StudentCubit cubit = StudentCubit.get(context, false);
                  return DefaultTextButton(
                    label: 'view all'.toUpperCase(),
                    style: kStyleRedAccentBold14,
                    onPressed: () {
                      cubit.changeBottomNavBar(1);
                    },
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(
          // height: 320.0,
          height: 260.0,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            itemBuilder: (context, index) =>
                TrainingCardWidget(post: posts[index]),
            separatorBuilder: (context, index) => const SizedBox(
              width: 20.0,
            ),
            itemCount: posts.length <= 2 ? posts.length : 2,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );

Widget trendingTrainingSection(List<TrainingPostModel> posts) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Students are viewing',
            style: kStyleBlackLightBold18,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              TrainingPostWidget(post: posts[index]),
          itemCount: posts.length,
        ),
      ],
    );
