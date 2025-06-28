import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/helpers/user_info_validator.dart';
import 'package:potential/features/onboarding/views/signin.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/features/onboarding/widgets/register_options.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/onboarding/helpers/onboarding_helper.dart';
import 'package:potential/features/onboarding/views/profile_creation.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final OnboardingHelperClass onBoardingHelper = OnboardingHelperClass();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void changePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void changeConfirmPasswordVisibility() {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _goToProfileCreation() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Please fill in all fields",
      );
      return;
    }
    if (!UserInfoValidator.isPasswordsMatch(
      passwordController.text.toString(),
      confirmPasswordController.text.toString(),
    )) {
      CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Passwords do not match",
      );
      return;
    }
    if (UserInfoValidator.isPasswordValid(passwordController.text.toString()) ==
        "Password is valid") {
      Navigator.pushReplacement(
        context,
        FadeRouteTransition(dest: ProfileCreationScreen()),
      );
    } else {
      CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Password is not valid}",
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
            minWidth: screenWidth,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Icon
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.05),
                  width: screenWidth * 0.85,
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  child: BackButtonWidget(),
                ),

                // Main Content
                Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.8,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hi, Welcome! \u{1F44B}",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    OnboardingTextfield(
                      labelText: "Email",
                      hintText: "example@gmail.com",
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      onChanged: (value) => context
                          .read<CreateAccountCubit>()
                          .updateEmail(emailController.text),
                    ),
                    OnboardingTextfield(
                      labelText: "Create a password",
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      isPassword: !isPasswordVisible,
                      controller: passwordController,
                      onChanged: (value) => context
                          .read<CreateAccountCubit>()
                          .updatePassword(passwordController.text),
                      suffixIcon: IconButton(
                        onPressed: changePasswordVisibility,
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    OnboardingTextfield(
                      labelText: "Confirm password",
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      isPassword: !isConfirmPasswordVisible,
                      controller: confirmPasswordController,
                      onChanged: (value) => context
                          .read<CreateAccountCubit>()
                          .updateConfirmPassword(
                            confirmPasswordController.text,
                          ),
                      suffixIcon: IconButton(
                        onPressed: changeConfirmPasswordVisibility,
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            width: screenWidth,
                            height: screenHeight * 0.3,
                            decoration: BoxDecoration(
                              color: AppColors.accentWhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Password should contain at least:"),
                                  Text("I. 8 Characters"),
                                  Text("II. 1 Uppercase Letter"),
                                  Text("III. 1 Lowercase Letter"),
                                  Text("IV. 1 Digit"),
                                  Text("V. 1 Special Character"),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        "Show password requirements",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    Hero(
                      tag: "signInButtonWelcomeScreen",
                      child: OnboardingButton(
                        onPressed: _goToProfileCreation,
                        text: "Create Account",
                      ),
                    ),
                    // Already have an account? Sign Up
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Alread have an account?",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              FadeRouteTransition(dest: SignInPage()),
                            ),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                color: AppColors.accentWhite,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                RegisterOptions(text: "register", task: "create"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
