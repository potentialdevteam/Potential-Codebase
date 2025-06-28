import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class ProfileEducation extends StatefulWidget {
  const ProfileEducation({super.key});

  @override
  State<ProfileEducation> createState() => _ProfileEducationState();
}

class _ProfileEducationState extends State<ProfileEducation> {
  int? selectedCheckboxIndex;
  final List<String> _educationLevels = [
    "Secondary School",
    "Undergrad",
    "Postgrad",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final String selectedEducation = context
        .read<CreateAccountCubit>()
        .state
        .education
        .value;

    selectedCheckboxIndex = _educationLevels.indexOf(selectedEducation);
    if (selectedCheckboxIndex == -1) {
      selectedCheckboxIndex = 0;
    }
  }

  void selectEducation() {
    if (selectedCheckboxIndex != null) {
      context.read<CreateAccountCubit>().updateEducation(
        _educationLevels[selectedCheckboxIndex!].toString(),
      );
    } else {
      CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Please select an education level",
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
            "Highest level of education you've completed",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _educationLevels.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _educationLevels[index],
                      style: TextStyle(color: AppColors.accentWhite),
                    ),
                    Checkbox(
                      value: selectedCheckboxIndex == index,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedCheckboxIndex = value! ? index : null;
                        });
                        selectEducation();
                      },
                      activeColor: AppColors.accentRed,
                    ),
                  ],
                );
              },
            ),
          ),

          Text(
            "This is an optional field.",
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
                          .education
                          .isVisibleToAll ??
                      false,
                  onChanged: (value) {
                    if (selectedCheckboxIndex != null) {
                      context.read<CreateAccountCubit>().updateEducation(
                        _educationLevels[selectedCheckboxIndex!].toString(),
                        isVisibleToAll: value ?? false,
                      );
                    } else {
                      CustomSnackBarHelper.showCustomSnackbar(
                        context,
                        "Please select an education level first",
                      );
                    }
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
