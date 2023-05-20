// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/components/default_text_button.dart';
import '../../shared/components/rounded_material_button.dart';
import '../../shared/components/rounded_text_field_shadow_above.dart';
import '../../shared/styles/styles.dart';
import '../complete_setup_profile/complete_setup_profile.dart';
import '../register_screen/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginCacheUserIdSuccessState) {
            navigateAndFinish(
              context,
              const SetupProfile(),
              // const StudentLayout(),
            );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.toString()),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    bottom: 60.0,
                  ),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign In',
                          style: kStyleBlackBold28,
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        RoundedTextFieldShadowAbove(
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email Address',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid E-mail';
                            }
                            return null;
                          },
                          isAutoFocus: true,
                          onSaved: cubit.saveUserEmail,
                        ),
                        RoundedTextFieldShadowAbove(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your password';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                              cubit.icon,
                              color: Colors.black,
                            ),
                            splashRadius: 15.0,
                            onPressed: cubit.changeVisibility,
                          ),
                          obscureText: cubit.obscurePassword,
                          onSaved: cubit.saveUserPassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => cubit.trySignin(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RoundedMaterialButton(
                          label: 'Sign In',
                          onPressed: cubit.trySignin,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have?',
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
