import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/views/create_account.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/features/onboarding/widgets/register_options.dart';
import 'package:potential/features/auth/cubits/auth.dart';
import 'package:potential/features/auth/cubits/signin_cubit.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/home/views/layout.dart';
import 'package:potential/features/onboarding/views/forgot_password.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _goToForgotPassword() {
    Navigator.push(context, FadeRouteTransition(dest: const ForgotPassword()));
  }

  _signIn() {
    final email = emailController.text.toString();
    final password = passwordController.text.toString();
    if (email.isEmpty || password.isEmpty) {
      CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Please fill in all fields.",
      );
      return;
    }
    if (password.length < 6) {
      CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Password must be at least 6 characters long.",
      );
      return;
    }
    context.read<SigninCubit>().updateProviderType(ProviderType.email);
    context.read<AuthCubit>().updateAuthData(
      email: emailController.text.toString(),
      isLoggedIn: true,
    );
    Navigator.pushAndRemoveUntil(
      context,
      FadeRouteTransition(dest: HomeLayout()),
      (Route<dynamic> route) => false,
    );
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
                      onChanged: (value) {
                        context.read<SigninCubit>().updateEmail(
                          emailController.text,
                        );
                      },
                    ),
                    OnboardingTextfield(
                      labelText: "Password",
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      isPassword: isPasswordVisible,
                      controller: passwordController,
                      onChanged: (value) {
                        context.read<SigninCubit>().updatePassword(
                          passwordController.text,
                        );
                      },
                      suffixIcon: IconButton(
                        onPressed: changePasswordVisibility,
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    // Remember Me Checkbox
                    Container(
                      alignment: Alignment.centerRight,
                      width: screenWidth * 0.8,
                      child: TextButton(
                        onPressed: _goToForgotPassword,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ),
                    // SignInButton
                    Hero(
                      tag: "signInButtonWelcomeScreen",
                      child: OnboardingButton(
                        onPressed: _signIn,
                        text: "Sign In",
                      ),
                    ),
                    // Already have an account? Sign Up
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              FadeRouteTransition(dest: CreateAccountPage()),
                            ),
                            child: Text(
                              "Sign Up",
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

                RegisterOptions(text: "Sign In", task: "signin"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
