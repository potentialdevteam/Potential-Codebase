import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class ProfileGender extends StatefulWidget {
  const ProfileGender({super.key});

  @override
  State<ProfileGender> createState() => _ProfileGenderState();
}

class _ProfileGenderState extends State<ProfileGender> {
  int? selectedCheckboxIndex;
  late final List<String> _genders;

  @override
  void initState() {
    super.initState();
    _genders = ["Man", "Woman", "Other"];
    final String selectedGender = context
        .read<CreateAccountCubit>()
        .state
        .gender
        .value;

    selectedCheckboxIndex = _genders.indexOf(selectedGender);
    if (selectedCheckboxIndex == -1) {
      selectedCheckboxIndex = 0;
      context.read<CreateAccountCubit>().updateGender(_genders[0]);
    }
  }

  void selectGender() {
    if (selectedCheckboxIndex != null) {
      context.read<CreateAccountCubit>().updateGender(
        _genders[selectedCheckboxIndex!].toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      width: MediaQuery.of(context).size.width * 0.80,
      child: Column(
        spacing: MediaQuery.of(context).size.height * 0.01,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Which gender best describes you?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            "You may choose any of the following three gender groups",
            style: TextStyle(color: Colors.white, fontSize: 13),
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
                      value: selectedCheckboxIndex == index,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedCheckboxIndex = value! ? index : null;
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
                BlocBuilder<CreateAccountCubit, CreateAccountData>(
                  builder: (context, state) {
                    return Checkbox(
                      value:
                          context
                              .watch<CreateAccountCubit>()
                              .state
                              .gender
                              .isVisibleToAll ??
                          false,
                      onChanged: (value) {
                        if (selectedCheckboxIndex != null) {
                          context.read<CreateAccountCubit>().updateGender(
                            _genders[selectedCheckboxIndex!].toString(),
                            isVisibleToAll: value ?? false,
                          );
                        } else {
                          CustomSnackBarHelper.showCustomSnackbar(
                            context,
                            "Please select a gender first",
                          );
                        }
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
        ],
      ),
    );
  }
}
