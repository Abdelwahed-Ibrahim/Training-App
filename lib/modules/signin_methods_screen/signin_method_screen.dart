import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/components/components.dart';
import '../../shared/components/default_text_button.dart';
import '../../shared/components/text_icon_button.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';
import '../login_screen/login_screen.dart';
import '../register_screen/register_screen.dart';

class SignInMethodsScreen extends StatelessWidget {
  const SignInMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: kColorTeal600,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: kColorTeal600,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 260.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                  color: kColorTeal600,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        'Here\'s to your goals',
                        style: kStyleWhiteNormal30,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Sign in so you can invest in yourself',
                        style: kStyleWhiteNormal20,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0),
                ),
              ),
              height: MediaQuery.of(context).size.height - 240,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign In',
                      style: kStyleBlackBold28,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextIconButton(
                      icon: const Icon(Icons.mail),
                      margin: const EdgeInsets.only(top: 20.0),
                      label: 'Sign In with email',
                      onPressed: () {
                        navigateAndFinish(
                          context,
                          const LoginScreen(),
                        );
                      },
                    ),
                    TextIconButton(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.redAccent,
                      ),
                      margin: const EdgeInsets.only(top: 20.0),
                      label: 'Sign In with Phone',
                      onPressed: () {},
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 25.0, bottom: 5.0),
                      child: const Center(
                        child: Text(
                          'OR',
                          style: kStyleGreyBold20,
                        ),
                      ),
                    ),
                    TextIconButton(
                      icon: const Icon(
                        Icons.apple_sharp,
                      ),
                      margin: const EdgeInsets.only(top: 20.0),
                      label: 'Sign In with Apple',
                      onPressed: () {},
                    ),
                    TextIconButton(
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                      margin: const EdgeInsets.only(top: 20.0),
                      label: 'Sign In with Facebook',
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'New here?',
                            style: kStyleBlackLightBold18,
                          ),
                          DefaultTextButton(
                            label: 'Create an account',
                            style: kStyleRedAccentBold18,
                            onPressed: () {
                              navigateAndFinish(
                                context,
                                const RegisterScreen(),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
