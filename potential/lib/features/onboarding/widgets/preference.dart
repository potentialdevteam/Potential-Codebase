import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class ProfilePreferences extends StatefulWidget {
  const ProfilePreferences({super.key});

  @override
  State<ProfilePreferences> createState() => _ProfilePreferencesState();
}

class _ProfilePreferencesState extends State<ProfilePreferences> {
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
    List<String> selectedGenderPreferences = [];
    for (int i = 0; i < selectedCheckboxes.length; i++) {
      if (selectedCheckboxes[i]) {
        selectedGenderPreferences.add(_genders[i]);
      }
    }
    if (selectedGenderPreferences.isEmpty) {
      CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Please select at least one gender preference.",
      );
    } else {
      context.read<CreateAccountCubit>().updateGenderPreference(
        selectedGenderPreferences,
        isVisibleToAll: value ?? false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      width: MediaQuery.of(context).size.width * 0.80,
      child: Column(
        spacing: MediaQuery.of(context).size.height * 0.02,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Your choice of preference?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            "You may choose any of the following three gender groups",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
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
                Checkbox(
                  value:
                      context
                          .watch<CreateAccountCubit>()
                          .state
                          .genderPreference
                          .isVisibleToAll ??
                      false,
                  onChanged: (value) {
                    selectGender(value: value);
                  },
                  activeColor: AppColors.accentRed,
                ),
                Text(
                  "Visible to everyone",
                  style: TextStyle(color: AppColors.accentWhite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
