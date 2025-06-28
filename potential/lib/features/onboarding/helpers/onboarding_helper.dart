import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/features/onboarding/widgets/age.dart';
import 'package:potential/features/onboarding/widgets/education.dart';
import 'package:potential/features/onboarding/widgets/gender.dart';
import 'package:potential/features/onboarding/widgets/location.dart';
import 'package:potential/features/onboarding/widgets/name.dart';
import 'package:potential/features/onboarding/widgets/preference.dart';
import 'package:potential/features/onboarding/widgets/social_handle.dart';
import 'package:potential/features/onboarding/views/voice_prompt.dart';
import 'package:potential/features/onboarding/widgets/work.dart';

class OnboardingHelperClass {
  // Profile Creation Maps of Screens
  static Map<int, Widget> getProfileCreationData() {
    return {
      0: const ProfileName(),
      1: const ProfileAge(),
      2: const ProfileGender(),
      3: const ProfilePreferences(),
      4: const ProfileLocation(),
      5: const ProfileEducation(),
      6: const ProfileWork(),
      7: const ProfileSocialHandle(),
      8: const ProfileVoicePrompt(),
      // 9: const ProfileLoveLanguage(),
      // 10: const ProfileInterests(),
    };
  }


  void updateAge(BuildContext context) {
    int currentYear = DateTime.now().year;
    String userDobString = context
        .read<CreateAccountCubit>()
        .state
        .dateOfBirth
        .value
        .split(" ")[0];

    log("userDobString : $userDobString");

    int userDobYear = int.parse(userDobString.split('-')[0]);

    context.read<CreateAccountCubit>().updateAge(currentYear - userDobYear);
  }

  bool allFieldsValid(BuildContext context) {
    String name = context
        .read<CreateAccountCubit>()
        .state
        .name
        .value;
    String dateOfBirth = context
        .read<CreateAccountCubit>()
        .state
        .dateOfBirth
        .value;
    String gender = context
        .read<CreateAccountCubit>()
        .state
        .gender
        .value;
    List<String> genderPreference = context
        .read<CreateAccountCubit>()
        .state
        .genderPreference
        .value;
    String location = context
        .read<CreateAccountCubit>()
        .state
        .location
        .value;
    String socialMediaHandle = context
        .read<CreateAccountCubit>()
        .state
        .socialMediaHandle
        .value;

    return name.isNotEmpty &&
        dateOfBirth.isNotEmpty &&
        gender.isNotEmpty &&
        genderPreference.isNotEmpty &&
        location.isNotEmpty &&
        socialMediaHandle.isNotEmpty;
  }
}
