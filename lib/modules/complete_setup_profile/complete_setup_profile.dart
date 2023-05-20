import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../layout/company_layout/layout.dart';
import '../../layout/student_layout/student_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/default_text_form_field.dart';
import '../../shared/components/loading_widget.dart';
import '../../shared/components/rounded_material_button.dart';
import '../../shared/constants.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SetupProfile extends StatelessWidget {
  const SetupProfile({super.key, this.openAsSettings = false});

  final bool openAsSettings;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CompleteProfileCubit()..getIsProfileCompleted(openAsSettings),
      child: BlocConsumer<CompleteProfileCubit, CompleteProfileStates>(
        listener: (context, state) {
          if (openAsSettings == false) {
            if (state is CompleteProfileSuccessState) {
              isCompany == true
                  ? navigateAndFinish(context, const Layout())
                  : navigateAndFinish(context, const StudentLayout());
            }
          }
        },
        builder: (context, state) {
          CompleteProfileCubit cubit = CompleteProfileCubit.get(context);
          return Scaffold(
            appBar: !openAsSettings
                ? AppBar(
                    title: const Text(
                      'Setup Profile',
                      style: kStyleBlackBold30,
                    ),
                  )
                : null,
            body: (cubit.name == null &&
                    cubit.email == null &&
                    cubit.phone == null)
                ? const LoadingWidget(label: 'Waiting for your information')
                : Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: cubit.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 20.0,
                                    top: openAsSettings ? 20.0 : 0.0,
                                  ),
                                  child: const Text(
                                    'Profile Image:',
                                    style: kStyleRedAccentLightBold20,
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.redAccent,
                                    radius: 77.0,
                                    child: (cubit.profileImage == null)
                                        ? CircleAvatar(
                                            backgroundColor: Colors.redAccent,
                                            radius: 75.0,
                                            backgroundImage:
                                                NetworkImage(cubit.avatarURL!),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.redAccent,
                                            radius: 75.0,
                                            backgroundImage:
                                                FileImage(cubit.profileImage!),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, bottom: 4.0),
                                    child: CircleAvatar(
                                      radius: 16,
                                      child: Material(
                                        color: kColorGrey100,
                                        clipBehavior: Clip.antiAlias,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: cubit.pickProfileImage,
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            size: 20.0,
                                            color: Colors.redAccent,
                                          ),
                                          splashRadius: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InformationRowItem(
                                prefixIcon: Icons.person,
                                prefixText: 'Name :',
                                hintText: 'Enter your name',
                                isEditingAllowed: cubit.allowEditingName,
                                controller: cubit.nameController,
                                onSavePressed: cubit.savingMyName,
                                onEditPressed: cubit.allowingEditName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your name';
                                  } else if (value.length < 7) {
                                    return 'Name must be at least 7 characters';
                                  }
                                  return null;
                                },
                                text: cubit.name,
                              ),
                              InformationRowItem(
                                prefixIcon: Icons.phone,
                                prefixText: 'Phone :',
                                hintText: 'Enter your phone',
                                isEditingAllowed: cubit.allowEditingPhone,
                                controller: cubit.phoneController,
                                onSavePressed: cubit.savingMyPhone,
                                onEditPressed: cubit.allowingEditPhone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your phone';
                                  } else if (value.length != 11 ||
                                      !value.startsWith('01')) {
                                    return 'Please enter a valid phone';
                                  }
                                  return null;
                                },
                                text: cubit.phone,
                              ),
                              InformationRowItem(
                                prefixIcon: Icons.email,
                                prefixText: 'E-Mail :',
                                hintText: 'Enter your Email Address',
                                isEditingAllowed: cubit.allowEditingEmail,
                                controller: cubit.emailController,
                                onSavePressed: cubit.savingMyEmail,
                                onEditPressed: cubit.allowingEditEmail,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter a valid E-mail';
                                  }
                                  return null;
                                },
                                text: cubit.email,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.place_rounded,
                                      color: Colors.redAccent,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    const Text(
                                      'Address :',
                                      style: kStyleRedAccentLightBold20,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: InkWell(
                                          onTap: cubit.getCurrentLocation,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(
                                                Icons.location_on,
                                                color: kColorDefault,
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                'Locate',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: kColorDefault,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (cubit.location != null)
                                Container(
                                  width: double.infinity,
                                  height: 190,
                                  margin: const EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      width: .8,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: GoogleMap(
                                      key: ValueKey(
                                          cubit.location!.toMap().toString()),
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(cubit.location!.latitude,
                                            cubit.location!.longitude),
                                        zoom: 15,
                                      ),
                                      markers: {
                                        Marker(
                                          markerId: const MarkerId('m1'),
                                          position: LatLng(
                                            cubit.location!.latitude,
                                            cubit.location!.longitude,
                                          ),
                                        )
                                      },
                                      scrollGesturesEnabled: false,
                                    ),
                                  ),
                                ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 5.0, bottom: 20.0),
                                child: RoundedMaterialButton(
                                  label: openAsSettings ? 'Update' : 'Complete',
                                  onPressed: cubit.postMyProfileInfo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class InformationRowItem extends StatelessWidget {
  const InformationRowItem({
    super.key,
    required this.prefixIcon,
    required this.prefixText,
    required this.hintText,
    required this.text,
    required this.isEditingAllowed,
    required this.controller,
    required this.onSavePressed,
    required this.onEditPressed,
    required this.validator,
  });

  final IconData prefixIcon;
  final String prefixText;
  final String hintText;
  final String? text;
  final bool isEditingAllowed;
  final TextEditingController controller;
  final void Function()? onSavePressed;
  final void Function()? onEditPressed;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Icon(
            prefixIcon,
            color: Colors.redAccent,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            prefixText,
            style: kStyleRedAccentLightBold20,
          ),
          if (!isEditingAllowed)
            const SizedBox(
              width: 10.0,
            ),
          Expanded(
            child: isEditingAllowed
                ? DefaultTextFormField(
                    controller: controller,
                    hintText: hintText,
                    autoFocus: true,
                    suffixIcon: Icons.save,
                    onSuffixPressed: onSavePressed,
                    onSubmit: (value) {
                      onSavePressed!();
                    },
                    validator: validator,
                  )
                : Text(
                    text ?? '',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          if (!isEditingAllowed)
            IconButton(
              onPressed: onEditPressed,
              icon: const Icon(
                Icons.edit,
                color: Colors.redAccent,
              ),
              constraints: BoxConstraints.loose(
                const Size.fromRadius(20.0),
              ),
              padding: EdgeInsets.zero,
              splashRadius: 15.0,
            )
        ],
      ),
    );
  }
}
