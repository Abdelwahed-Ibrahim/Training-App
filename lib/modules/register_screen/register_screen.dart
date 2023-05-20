// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/components/default_radio_list_tile.dart';
import '../../shared/components/default_text_button.dart';
import '../../shared/components/rounded_material_button.dart';
import '../../shared/components/rounded_text_field_shadow_above.dart';
import '../../shared/styles/styles.dart';
import '../complete_setup_profile/complete_setup_profile.dart';
import '../signin_methods_screen/signin_method_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterCacheUserIdSuccessState) {
            navigateAndFinish(
              context,
              const SetupProfile(),
            );
          } else if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.toString()),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
            print(state.error);
          } else if (state is RegisterCreateUserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    state.error.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Create an account',
                          style: kStyleBlackBold28,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        RoundedTextFieldShadowAbove(
                          keyboardType: TextInputType.name,
                          hintText: 'Your name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your name';
                            } else if (value.length < 7) {
                              return 'Name must be at least 7 characters';
                            }
                            return null;
                          },
                          isAutoFocus: true,
                          onSaved: cubit.saveUserName,
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
                          onSaved: cubit.saveUserEmail,
                        ),
                        RoundedTextFieldShadowAbove(
                          keyboardType: TextInputType.phone,
                          hintText: 'Phone',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your phone';
                            } else if (value.length != 11 ||
                                !value.startsWith('01')) {
                              return 'Please enter a valid phone';
                            }
                            return null;
                          },
                          onSaved: cubit.saveUserPhone,
                        ),
                        RoundedTextFieldShadowAbove(
                          keyboardType: TextInputType.visiblePassword,
                          controller: cubit.passController,
                          hintText: 'Password (6+ characters)',
                          suffixIcon: IconButton(
                            icon: Icon(
                              cubit.iconPass,
                              color: Colors.black,
                            ),
                            splashRadius: 15.0,
                            onPressed: cubit.changePassVisibility,
                          ),
                          obscureText: cubit.obscurePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your password';
                            } else if (value.length < 6) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          onSaved: cubit.saveUserPassword,
                        ),
                        RoundedTextFieldShadowAbove(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Re-enter your password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              cubit.iconRePass,
                              color: Colors.black,
                            ),
                            splashRadius: 15.0,
                            onPressed: cubit.changeConfirmPassVisibility,
                          ),
                          obscureText: cubit.obscureConfirmPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Re-enter your password';
                            } else if (value != cubit.passController.text) {
                              return 'your Password doesn\'t match';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'What do you want to Register as?',
                          style: kStyleRedAccentLightBold18,
                        ),
                        DefaultRadioListTile(
                          title: AccountType.Company.name,
                          value: AccountType.Company,
                          groupValue: cubit.accountType,
                          onChanged: cubit.changeAccountType,
                        ),
                        DefaultRadioListTile(
                          title: AccountType.Student.name,
                          value: AccountType.Student,
                          groupValue: cubit.accountType,
                          onChanged: cubit.changeAccountType,
                        ),
                        RoundedMaterialButton(
                          onPressed: cubit.tryRegister,
                          label: 'Create an account',
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Center(
                          child: Text(
                            'By clicking on "Create an account" you agree to our Terms of Use and Privacy Policy',
                            style: kStyleBlackNormal12,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account!',
                              style: kStyleBlackLightBold18,
                            ),
                            DefaultTextButton(
                              label: 'Sign in',
                              style: kStyleRedAccentBold18,
                              onPressed: () {
                                navigateAndFinish(
                                  context,
                                  const SignInMethodsScreen(),
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
