import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../layout/company_layout/cubit/cubit.dart';
import '../../layout/company_layout/cubit/states.dart';
import '../../shared/components/check_list_item.dart';
import '../../shared/components/default_divider.dart';
import '../../shared/components/default_icon_button.dart';
import '../../shared/components/default_radio_list_tile.dart';
import '../../shared/components/default_text_button.dart';
import '../../shared/components/default_text_form_field.dart';
import '../../shared/components/hash_tag_widget.dart';
import '../../shared/components/rounded_material_icon_button.dart';
import '../../shared/components/text_icon_button.dart';
import '../../shared/components/write_submit_text_field.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';

class UploadTrainingScreen extends StatelessWidget {
  const UploadTrainingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, LayoutStates>(
      listener: (context, state) {
        if (state is NoSelectedImageErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        if (state is TagsEmptyErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        if (state is LearnedTitlesEmptyErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        if (state is NoCategoryTypeSelectedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error.toString(),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        if (state is UploadTrainingSuccessState) {
          CompanyCubit.get(context, false).changeDrawerScreen(0);
        }
      },
      builder: (context, state) {
        CompanyCubit cubit = CompanyCubit.get(context, false);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTrainingMetaData(cubit),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextFormField(
                          hintText: 'Training Title',
                          controller: cubit.trainingTitleController,
                          alignCenter: false,
                          maxLines: 2,
                          textCapitalization: TextCapitalization.words,
                          validator: cubit.validateTrainingTitle,
                          onSaved: cubit.saveTrainingTitle,
                        ),
                        if (cubit.trainingImage == null)
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              icon: const Icon(
                                  Icons.add_photo_alternate_outlined),
                              onPressed: cubit.pickTrainingImage,
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.teal),
                                overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.teal.withOpacity(.2),
                                ),
                              ),
                              label: const Text('Upload Image'),
                            ),
                          ),
                        if (cubit.trainingImage == null)
                          Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Text('No Image Selected'),
                            ),
                          ),
                        if (cubit.trainingImage != null)
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image(
                                image: FileImage(cubit.trainingImage!),
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: kColorGrey300,
                                  child: DefaultIconButton(
                                    onPressed: cubit.removePickedImage,
                                    icon: Icons.close,
                                    color: Colors.teal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        const DefaultDivider(),
                        //ToDo : Allow Add Tags, Description, Learned Titles.
                        // Description Section
                        DefaultTextFormField(
                          hintText: 'Training Description',
                          controller: cubit.trainingDescriptionController,
                          alignCenter: false,
                          minLines: 5,
                          maxLines: 5,
                          validator: cubit.validateTrainingDescription,
                          onSaved: cubit.saveTrainingDescription,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const DefaultDivider(),
                        // Tags Section
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              const Text(
                                'Add Tags :',
                                style: kStyleRedAccentLightBold20,
                              ),
                              const Spacer(),
                              TextIconButton(
                                icon: const Icon(Icons.add),
                                label: 'Add Tag',
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => WriteSubmitTextField(
                                      hint: 'Write Single Tag...',
                                      textController: cubit.tagController,
                                      isSubmitAllowed: true,
                                      allowSubmitting: (value) {},
                                      submitWidget: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        clipBehavior: Clip.antiAlias,
                                        child: ClipRRect(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: DefaultTextButton(
                                            onPressed: () {
                                              cubit.addTag();
                                              Navigator.pop(context);
                                            },
                                            label: 'add'.toUpperCase(),
                                            style: kStyleRedAccentBold18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            children: [
                              for (var tag in cubit.tags)
                                HashTagWidget(tag: tag),
                            ],
                          ),
                        ),
                        const DefaultDivider(),
                        // Learned Titles Section
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              const Text(
                                'Learned Titles :',
                                style: kStyleRedAccentLightBold20,
                              ),
                              const Spacer(),
                              TextIconButton(
                                icon: const Icon(Icons.add),
                                label: 'Add Title',
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => WriteSubmitTextField(
                                      hint: 'Write A Title Here...',
                                      textController: cubit.titleController,
                                      allowSubmitting: (value) {},
                                      isSubmitAllowed: true,
                                      submitWidget: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        clipBehavior: Clip.antiAlias,
                                        child: ClipRRect(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: DefaultTextButton(
                                            onPressed: () {
                                              cubit.addTitle();
                                              Navigator.pop(context);
                                            },
                                            label: 'add'.toUpperCase(),
                                            style: kStyleRedAccentBold18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            for (var title in cubit.learnedTitles)
                              CheckListItem(
                                item: title,
                              )
                          ],
                        ),
                        const DefaultDivider(),
                        const Text(
                          'Select Training Category :',
                          style: kStyleRedAccentLightBold20,
                        ),
                        DefaultRadioListTile(
                          title: CategoryType.Design.name,
                          value: CategoryType.Design,
                          groupValue: cubit.categoryType,
                          onChanged: cubit.changeCategoryType,
                        ),
                        DefaultRadioListTile(
                          title: CategoryType.Development.name,
                          value: CategoryType.Development,
                          groupValue: cubit.categoryType,
                          onChanged: cubit.changeCategoryType,
                        ),
                        DefaultRadioListTile(
                          title: CategoryType.Business.name,
                          value: CategoryType.Business,
                          groupValue: cubit.categoryType,
                          onChanged: cubit.changeCategoryType,
                        ),
                        DefaultRadioListTile(
                          title: 'Office Productivity',
                          value: CategoryType.Office_Productivity,
                          groupValue: cubit.categoryType,
                          onChanged: cubit.changeCategoryType,
                        ),
                        DefaultRadioListTile(
                          title: 'Finance And Accounting',
                          value: CategoryType.Finance_And_Accounting,
                          groupValue: cubit.categoryType,
                          onChanged: cubit.changeCategoryType,
                        ),
                        DefaultRadioListTile(
                          title: 'IT And Software',
                          value: CategoryType.IT_And_Software,
                          groupValue: cubit.categoryType,
                          onChanged: cubit.changeCategoryType,
                        ),
                        DefaultRadioListTile(
                          title: CategoryType.Marketing.name,
                          value: CategoryType.Marketing,
                          groupValue: cubit.categoryType,
                          onChanged: cubit.changeCategoryType,
                        ),
                        DefaultRadioListTile(
                          title: CategoryType.Photography.name,
                          value: CategoryType.Photography,
                          groupValue: cubit.categoryType,
                          onChanged: cubit.changeCategoryType,
                        ),
                        const DefaultDivider(),
                        //ToDo : Starting Date with Showing Date Picker.
                        Row(
                          children: [
                            const Text(
                              'Starting Date :',
                              style: kStyleRedAccentLightBold20,
                            ),
                            Expanded(
                              child: DefaultTextFormField(
                                hintText: 'Pick Date',
                                isReadOnly: true,
                                controller: cubit.dateController,
                                validator: cubit.validateStartingDate,
                                onSaved: cubit.saveStartingDate,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-12-31'),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: Colors.teal,
                                            onPrimary: Colors.tealAccent,
                                            onSurface: Colors.redAccent,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors
                                                  .teal, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  ).then(cubit.pickDate);
                                },
                              ),
                            )
                          ],
                        ),
                        const DefaultDivider(),
                        //ToDo : Total Hours, Hours Per Week And Required Student Numbers.
                        const Text(
                          'Total Hours :',
                          style: kStyleRedAccentLightBold20,
                        ),
                        DefaultTextFormField(
                          hintText: 'Training Total Hours',
                          keyboardType: TextInputType.number,
                          controller: cubit.hoursController,
                          validator: cubit.validateTotalHours,
                          onSaved: cubit.saveTotalHours,
                          textInputAction: TextInputAction.next,
                        ),
                        const DefaultDivider(),
                        const Text(
                          'Hours Per Week :',
                          style: kStyleRedAccentLightBold20,
                        ),
                        DefaultTextFormField(
                          hintText: 'Training Hours Every Week',
                          keyboardType: TextInputType.number,
                          controller: cubit.hoursPerWeekController,
                          validator: cubit.validateHoursPerWeek,
                          onSaved: cubit.saveHoursPerWeek,
                          textInputAction: TextInputAction.next,
                        ),
                        const DefaultDivider(),
                        const Text(
                          'Required Student Number:',
                          style: kStyleRedAccentLightBold20,
                        ),
                        DefaultTextFormField(
                          hintText: 'Total Student No',
                          keyboardType: TextInputType.number,
                          onSubmit: (_) => cubit.postTraining(),
                          controller: cubit.studentNoController,
                          validator: cubit.validateStudentNumbers,
                          onSaved: cubit.saveStudentNumbers,
                        ),
                        SizedBox(
                          height: 40,
                          child: RoundedMaterialIconButton(
                            label: 'Post Training',
                            toUpperCase: false,
                            icon: Icons.post_add_outlined,
                            onPressed: cubit.postTraining,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row buildTrainingMetaData(CompanyCubit cubit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(cubit.company!.avatarUrl!),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cubit.company!.name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat('MMMM d, yyyy At h:mm a')
                    .format(DateTime.now())
                    .toString(),
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
