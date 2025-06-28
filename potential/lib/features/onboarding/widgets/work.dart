import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';

class ProfileWork extends StatefulWidget {
  const ProfileWork({super.key});

  @override
  State<ProfileWork> createState() => _ProfileWorkState();
}

class _ProfileWorkState extends State<ProfileWork> {
  late TextEditingController workController;

  @override
  void initState() {
    super.initState();
    workController = TextEditingController(
      text: context
          .read<CreateAccountCubit>()
          .state
          .workExperience
          .value
          .toString(),
    );
  }

  @override
  void dispose() {
    workController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              "Where do you work?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),

            OnboardingTextfield(
              labelText: "Enter your workplace",
              hintText: "Example : Google , Microsoft",
              keyboardType: TextInputType.number,
              controller: workController,
              onChanged: (value) {
                context.read<CreateAccountCubit>().updateWorkExperience(value);
              },
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
                            .workExperience
                            .isVisibleToAll ??
                        false,
                    onChanged: (value) {
                      context.read<CreateAccountCubit>().updateWorkExperience(
                        workController.text,
                        isVisibleToAll: value ?? false,
                      );
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
      ),
    );
  }
}
