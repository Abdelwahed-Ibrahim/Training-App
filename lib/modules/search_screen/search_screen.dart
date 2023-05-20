import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/student_layout/cubit/cubit.dart';
import '../../layout/student_layout/cubit/states.dart';
import '../../models/training_data.dart';
import '../../models/training_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/default_icon_button.dart';
import '../../shared/components/hash_tag_widget.dart';
import '../../shared/components/rounded_rectangle_ink_well.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';
import '../post_screen/post_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key, this.searchedText = ''}) : super(key: key);

  final String searchedText;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (searchedText.isNotEmpty) {
      StudentCubit.get(context, false)
          .searchTrainings(searchedText, isTag: true);
      _searchController.text = '#$searchedText';
    }
    return BlocConsumer<StudentCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        StudentCubit cubit = StudentCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultIconButton(
                        icon: Icons.arrow_back,
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        height: 35.0,
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25.0)),
                                borderSide: BorderSide(color: kColorGrey100!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25.0)),
                                borderSide: BorderSide(color: kColorGrey100!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25.0)),
                                borderSide: BorderSide(color: kColorGrey100!),
                              ),
                              fillColor: kColorGrey100,
                              contentPadding: const EdgeInsets.all(8.0),
                              hintText: 'Search',
                              hintStyle: TextStyle(color: kColorGrey400),
                              suffixIcon: Material(
                                color: kColorGrey100,
                                borderRadius: BorderRadius.circular(50),
                                clipBehavior: Clip.antiAlias,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: kColorGrey400,
                                      size: 20.0,
                                    ),
                                    splashRadius: 15.0,
                                    onPressed: () {
                                      // if (commentController.text != '') {
                                      //   cubit.postComment(
                                      //     postId,
                                      //     commentController.text,
                                      //   );
                                      //   cubit.allowSendComment = false;
                                      //   Navigator.pop(context);
                                      // }
                                    }),
                              )),
                          onChanged: (String searchedText) {
                            cubit.searchTrainings(searchedText);
                          },
                          controller: _searchController,
                          autofocus: searchedText.isEmpty ? true : false,
                        ),
                      ),
                    ],
                  ),
                  categoriesSection(context, _searchController),
                  const SizedBox(height: 20),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TrainingSearchItem(
                      postModel: cubit.searchedTrainings[index],
                      controller: _searchController,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: cubit.searchedTrainings.length,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget categoriesSection(
  BuildContext context,
  TextEditingController controller,
) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Text(
            'Browse Categories',
            style: kStyleGreyBold20,
          ),
        ),
        Wrap(
          children: [
            for (var category in categories)
              RoundedRectangleInkWell(
                  label: category,
                  onTap: () {
                    controller.text = category;
                    StudentCubit.get(context, false).searchTrainings(
                      category,
                      isCategory: true,
                    );
                  }),
          ],
        ),
      ],
    );

class TrainingSearchItem extends StatelessWidget {
  const TrainingSearchItem(
      {super.key, required this.postModel, required this.controller});

  final TrainingPostModel postModel;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(context, PostScreen(post: postModel)),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 5.0,
        child: Container(
          width: double.infinity,
          color: kColorGrey100,
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postModel.companyName,
                      style: kStyleRedAccentLightBold20,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      postModel.trainingTitle,
                      style: kStyleBlackNormal18,
                    ),
                    Wrap(
                      children: [
                        for (var tag in postModel.tags) HashTagWidget(tag: tag),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Category:',
                          style: kStyleRedAccentLightBold18,
                        ),
                        RoundedRectangleInkWell(
                            label: postModel.category,
                            onTap: () {
                              controller.text = postModel.category;
                              StudentCubit.get(context, false).searchTrainings(
                                postModel.category,
                                isCategory: true,
                              );
                            })
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 75.0,
                width: 120,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      postModel.trainingImage,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
