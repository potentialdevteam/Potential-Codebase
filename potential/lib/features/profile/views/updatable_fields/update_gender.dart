import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/profile/cubit/updatable_fields.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class UpdateGenderPreference extends StatefulWidget {
  const UpdateGenderPreference({super.key});

  @override
  State<UpdateGenderPreference> createState() => _UpdateGenderPreferenceState();
}

class _UpdateGenderPreferenceState extends State<UpdateGenderPreference> {
  late List<bool> selectedCheckboxes;
  late final List<String> _genders;

  @override
  void initState() {
    super.initState();
    _genders = ["Man", "Woman", "Other"];
    selectedCheckboxes = List.filled(_genders.length, false);

    final List<String> selectedGenders = context
        .read<CreateAccountCubit>()
        .state
        .genderPreference
        .value;

    for (var g in selectedGenders) {
      int idx = _genders.indexOf(g);
      if (idx == -1) {
        selectedCheckboxes[idx] = false;
      } else {
        selectedCheckboxes[idx] = true;
      }
    }
  }

  void selectGender({bool? value}) {
    final selectedGenderPreferences = <String>[];

    for (int i = 0; i < selectedCheckboxes.length; i++) {
      if (selectedCheckboxes[i]) {
        selectedGenderPreferences.add(_genders[i]);
      }
    }

    context.read<UpdatableFieldsCubit>().updateGenderPreference(
      selectedGenderPreferences,
      isVisibleToAll:
          value ??
          context
              .read<UpdatableFieldsCubit>()
              .state
              .genderPreference
              .isVisibleToAll ??
          false,
    );

    context.read<CreateAccountCubit>().updateGenderPreference(
      selectedGenderPreferences,
      isVisibleToAll:
          value ??
          context
              .read<CreateAccountCubit>()
              .state
              .genderPreference
              .isVisibleToAll ??
          false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        leading: BackButtonWidget(onPressed: () => _goBack(context)),
      ),
      backgroundColor: AppColors.bgBlack,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
          ),
          width: MediaQuery.of(context).size.width * 0.80,
          child: Column(
            spacing: MediaQuery.of(context).size.height * 0.02,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Update your choice of preference?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "You may choose any of the following three gender groups.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
                textAlign: TextAlign.left,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _genders.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _genders[index],
                          style: TextStyle(color: AppColors.accentWhite),
                        ),
                        Checkbox(
                          value: selectedCheckboxes[index],
                          onChanged: (bool? value) {
                            setState(() {
                              selectedCheckboxes[index] = value ?? false;
                            });
                            selectGender();
                          },
                          activeColor: AppColors.accentRed,
                        ),
                      ],
                    );
                  },
                ),
              ),

              Text(
                "This is a required field.",
                style: TextStyle(color: AppColors.accentWhite),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    BlocBuilder<UpdatableFieldsCubit, UpdatableFieldsData>(
                      builder: (context, state) {
                        return Checkbox(
                          value:
                              context
                                  .watch<CreateAccountCubit>()
                                  .state
                                  .genderPreference
                                  .isVisibleToAll ??
                              false,
                          onChanged: (bool? value) {
                            selectGender(value: value);
                          },
                          activeColor: AppColors.accentRed,
                        );
                      },
                    ),
                    Text(
                      "Visible to everyone",
                      style: TextStyle(color: AppColors.accentWhite),
                    ),
                  ],
                ),
              ),
              OnboardingButton(
                onPressed: () {
                  if (context
                      .read<UpdatableFieldsCubit>()
                      .state
                      .genderPreference
                      .value
                      .isEmpty) {
                    CustomSnackBarHelper.showCustomSnackbar(
                      context,
                      "Please select at least one gender.",
                    );
                  } else {
                    final pref = context
                        .read<UpdatableFieldsCubit>()
                        .state
                        .genderPreference
                        .value;
                    final isVisibleToAll = context
                        .read<UpdatableFieldsCubit>()
                        .state
                        .genderPreference
                        .isVisibleToAll;

                    context.read<CreateAccountCubit>().updateGenderPreference(
                      pref,
                      isVisibleToAll: isVisibleToAll,
                    );
                    Navigator.pop(context);
                  }
                },
                text: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }

  _goBack(BuildContext context) {
    final updatableFieldsState = context.read<UpdatableFieldsCubit>().state;
    final createAccountState = context.read<CreateAccountCubit>().state;

    if (updatableFieldsState.genderPreference.value !=
            createAccountState.genderPreference.value ||
        updatableFieldsState.genderPreference.isVisibleToAll !=
            createAccountState.genderPreference.isVisibleToAll) {
      return CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Please save your changes.",
      );
    }

    Navigator.pop(context);
  }
}
