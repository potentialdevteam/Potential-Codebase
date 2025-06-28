
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/features/profile/cubit/updatable_fields.dart';

class UpdateProfileHelper {
  static UpdatableFieldsData fetchUpdatableFieldsData(BuildContext context) {
    final createAccountState = context.read<CreateAccountCubit>().state;
    return UpdatableFieldsData(
      profilePicture: createAccountState.profilePicture,
      voicePrompt: createAccountState.voicePrompt,
      genderPreference: createAccountState.genderPreference,
      education: createAccountState.education,
      workExperience: createAccountState.workExperience,
      socialMediaHandle: createAccountState.socialMediaHandle,
      firstMove: createAccountState.firstMove,
      mysteryModeEnabled: createAccountState.mysteryModeEnabled,
    );
  }

  updateGenderPreferences(
    BuildContext context,
    List<String> newGenderPreferences,
  ) {
    context.read<UpdatableFieldsCubit>().updateGenderPreference(
      newGenderPreferences,
    );
  }
}
