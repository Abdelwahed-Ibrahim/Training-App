import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../modules/signin_methods_screen/signin_method_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CompanyCubit cubit = CompanyCubit.get(context, false);
        return Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Material(
              child: Column(
                children: [
                  SizedBox(
                    // padding: const EdgeInsets.only(top: 50.0),
                    height: 220,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(cubit.company!.avatarUrl!),
                            ),
                          ),
                        ),
                        Text(
                          cubit.company!.name,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          cubit.company!.email,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 0.5,
                          color: Colors.teal,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 50.0),
                    height: MediaQuery.of(context).size.height - 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Material(
                          child: InkWell(
                            onTap: () {
                              cubit.changeDrawerScreen(0);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Icon(Icons.home),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text('Home'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          child: InkWell(
                            onTap: () {
                              cubit.changeDrawerScreen(1);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Icon(Icons.post_add),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text('Upload Training'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          child: InkWell(
                            onTap: () {
                              cubit.changeDrawerScreen(2);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Icon(Icons.notifications),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text('Notifications'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          child: InkWell(
                            onTap: () {
                              cubit.changeDrawerScreen(3);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Icon(Icons.settings),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text('Settings'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          child: InkWell(
                            onTap: () async {
                              await TrainingApp.firebaseMessaging
                                  .unsubscribeFromTopic(cubit.company!.uId);
                              CacheHelper.clearData().then((value) {
                                navigateAndFinish(
                                    context, const SignInMethodsScreen());
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Icon(Icons.exit_to_app),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text('Log Out'),
                                  ),
                                ],
                              ),
                            ),
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
}
