import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/core/services/google_service.dart';
import 'package:potential/features/auth/cubits/auth.dart';
import 'package:potential/features/auth/cubits/signin_cubit.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/features/onboarding/views/welcome_landing.dart';
import 'package:potential/features/profile/cubit/user_questions_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  Future<void> logout(BuildContext context) async {
    await GoogleAuthClass().signOut(context);
    final prefs = await SharedPreferences.getInstance();
    if (context.mounted) {
      context.read<AuthCubit>().resetAuthData();
      context.read<SigninCubit>().reset();
      context.read<CreateAccountCubit>().reset();
      context.read<UserQuestionsCubit>().resetState();
      prefs.remove("hasSeenInfoDialog");
      Navigator.pushReplacement(
        context,
        FadeRouteTransition(dest: const WelcomeLanding()),
      );
    }
  }
}
