import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../layout/company_layout/cubit/cubit.dart';
import '../../layout/student_layout/cubit/cubit.dart';
import '../../shared/components/flat_button_widget.dart';
import '../../shared/components/loading_widget.dart';
import '../../shared/components/outlined_button_widget.dart';
import '../../shared/components/training_widget.dart';
import '../../shared/constants.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';
import '../route_screen/route_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.uId,
    this.notificationId,
    this.trainingId,
  });

  final String uId;
  final String? notificationId;
  final String? trainingId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserInfo(uId),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: .50,
              title: const Text(
                'Profile Screen',
              ),
            ),
            body: (cubit.student == null && cubit.company == null)
                ? const LoadingWidget(label: 'Loading information')
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 77,
                              child: CircleAvatar(
                                backgroundImage: isCompany == true
                                    ? NetworkImage(
                                        cubit.student!.avatarUrl!,
                                      )
                                    : NetworkImage(
                                        cubit.company!.avatarUrl!,
                                      ),
                                backgroundColor: Colors.grey,
                                radius: 75,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.redAccent,
                              ),
                              Expanded(
                                child: Text(
                                  isCompany == true
                                      ? cubit.student!.name
                                      : cubit.company!.name,
                                  textAlign: TextAlign.center,
                                  style: kStyleBlackLightBold20,
                                ),
                              ),
                            ],
                          ),
                          separator(),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.redAccent,
                              ),
                              Expanded(
                                child: Text(
                                  isCompany == true
                                      ? cubit.student!.phone
                                      : cubit.company!.phone,
                                  textAlign: TextAlign.center,
                                  style: kStyleBlackLightBold20,
                                ),
                              ),
                            ],
                          ),
                          separator(),
                          Row(
                            children: [
                              const Icon(
                                Icons.email,
                                color: Colors.redAccent,
                              ),
                              Expanded(
                                child: Text(
                                  isCompany == true
                                      ? cubit.student!.email
                                      : cubit.company!.email,
                                  textAlign: TextAlign.center,
                                  style: kStyleBlackLightBold20,
                                ),
                              ),
                            ],
                          ),
                          separator(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  color: Colors.redAccent,
                                ),
                                Expanded(
                                  child: Text(
                                    isCompany == true
                                        ? cubit.student!.location!.address!
                                        : cubit.company!.location!.address!,
                                    textAlign: TextAlign.center,
                                    style: kStyleBlackLightBold20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isCompany == true)
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButtonWidget(
                                    onPressed: () {
                                      BlocProvider.of<CompanyCubit>(context,
                                              listen: false)
                                          .addStudentToTraining(
                                        notificationId: notificationId!,
                                        trainingId: trainingId!,
                                        studentId: uId,
                                      );
                                      Navigator.pop(context);
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
                                      BlocProvider.of<CompanyCubit>(context,
                                              listen: false)
                                          .removeRequestStudentToTraining(
                                        notificationId: notificationId!,
                                        trainingId: trainingId!,
                                        studentId: uId,
                                      );
                                      Navigator.pop(context);
                                    },
                                    text: 'Remove',
                                  ),
                                ),
                              ],
                            ),
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
                                initialCameraPosition: CameraPosition(
                                  target: isCompany == true
                                      ? LatLng(
                                          cubit.student!.location!.latitude,
                                          cubit.student!.location!.longitude)
                                      : LatLng(
                                          cubit.company!.location!.latitude,
                                          cubit.company!.location!.longitude,
                                        ),
                                  zoom: 15,
                                ),
                                markers: {
                                  Marker(
                                    markerId: const MarkerId('m1'),
                                    position: isCompany == true
                                        ? LatLng(
                                            cubit.student!.location!.latitude,
                                            cubit.student!.location!.longitude,
                                          )
                                        : LatLng(
                                            cubit.company!.location!.latitude,
                                            cubit.company!.location!.longitude,
                                          ),
                                  )
                                },
                                scrollGesturesEnabled: false,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: double.infinity,
                            child: FlatButtonWidget(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RouteScreen(
                                      sourceLocation: isCompany == true
                                          ? BlocProvider.of<CompanyCubit>(
                                                  context)
                                              .company!
                                              .location!
                                          : BlocProvider.of<StudentCubit>(
                                                  context)
                                              .student!
                                              .location!,
                                      destinationLocation: isCompany == true
                                          ? cubit.student!.location!
                                          : cubit.company!.location!,
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                              text: 'View Route Map',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: cubit.userTrainings.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        TrainingWidget(
                                            post: cubit.userTrainings[index]),
                                    itemCount: cubit.userTrainings.length,
                                  )
                                : const SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        'No Trainings To Show',
                                        style: kStyleBlackLightBold20,
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget separator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      color: kColorGrey300,
      width: double.infinity,
      height: .5,
    );
  }
}
