import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/config.dart';
import 'layout/company_layout/cubit/cubit.dart';
import 'layout/company_layout/layout.dart';
import 'layout/student_layout/cubit/cubit.dart';
import 'layout/student_layout/student_layout.dart';
import 'modules/complete_setup_profile/complete_setup_profile.dart';
import 'modules/signin_methods_screen/signin_method_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/constants.dart';
import 'shared/network/local/cache_helper.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  TrainingApp.sharedPreferences = await SharedPreferences.getInstance();
  TrainingApp.auth = FirebaseAuth.instance;
  TrainingApp.firestore = FirebaseFirestore.instance;
  TrainingApp.firebaseStorage = FirebaseStorage.instance;
  TrainingApp.firebaseMessaging = FirebaseMessaging.instance;
  TrainingApp.myLocation = Location();
  TrainingApp.picker = ImagePicker();
  uId = await CacheHelper.getData(key: TrainingApp.userUID);
  isCompany = await CacheHelper.getData(key: TrainingApp.isCompany);
  isAccountComplete =
      await CacheHelper.getData(key: TrainingApp.isProfileComplete);
  late Widget screen;
  if (uId == null) {
    screen = const SignInMethodsScreen();
  } else {
    if (isAccountComplete != true) {
      screen = const SetupProfile();
    } else {
      screen = isCompany == true ? const Layout() : const StudentLayout();
    }
  }
  runApp(MyApp(screen));
}

var developing = false;

class MyApp extends StatelessWidget {
  const MyApp(this.screen, {Key? key}) : super(key: key);
  final Widget screen;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => StudentCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => CompanyCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              elevation: 0.0,
              iconTheme: IconThemeData(
                size: 20.0,
              ),
              foregroundColor: Colors.black,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
            )),
        home: screen,
      ),
    );
  }
}
