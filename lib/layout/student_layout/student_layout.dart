import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/config.dart';
import '../../modules/search_screen/search_screen.dart';
import '../../modules/signin_methods_screen/signin_method_screen.dart';
import '../../shared/components/action_input_button.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/styles.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// TrainingData data = TrainingData();

class StudentLayout extends StatefulWidget {
  const StudentLayout({super.key});

  @override
  State<StudentLayout> createState() => _StudentLayoutState();
}

class _StudentLayoutState extends State<StudentLayout> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<StudentCubit>(context).getStudentInfo();
    BlocProvider.of<StudentCubit>(context).getTrainings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.dark,
    // ));
    return BlocConsumer<StudentCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        StudentCubit cubit = StudentCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: false,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: kStyleBlackBold30,
            ),
            actions: [
              // ActionIconButton(
              //   icon: Icons.notifications,
              //   onPressed: () {
              //     navigateTo(context, const NotificationScreen());
              //   },
              // ),
              ActionIconButton(
                icon: Icons.search,
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
              ),
              ActionIconButton(
                  icon: Icons.exit_to_app,
                  onPressed: () async {
                    await TrainingApp.firebaseMessaging
                        .unsubscribeFromTopic(cubit.student!.uId);
                    await TrainingApp.firebaseMessaging
                        .unsubscribeFromTopic(TrainingApp.studentTopic);
                    CacheHelper.clearData().then((value) {
                      navigateAndFinish(context, const SignInMethodsScreen());
                    });
                  })
            ],
            // bottom: TabBar(
            //   physics: const BouncingScrollPhysics(),
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //   tabs: [
            //     Tab(text: categories[0]),
            //     Tab(text: categories[1]),
            //     Tab(text: categories[2]),
            //     Tab(text: categories[3]),
            //     Tab(text: categories[4]),
            //   ],
            //   labelColor: Colors.teal,
            //   unselectedLabelColor: Colors.grey,
            //   isScrollable: true,
            //   indicatorColor: Colors.teal,
            // ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: cubit.changeBottomNavBar,
            currentIndex: cubit.currentIndex,
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.black54,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.star_border),
                label: 'Features',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_outline),
                label: 'My Trainings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
