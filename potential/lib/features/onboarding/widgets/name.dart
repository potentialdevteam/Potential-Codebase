import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/features/onboarding/helpers/onboarding_helper.dart';
import 'package:potential/core/constants/colors.dart';

class ProfileName extends StatefulWidget {
  const ProfileName({super.key});

  @override
  State<ProfileName> createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  late TextEditingController nameController;
  final OnboardingHelperClass onboardingHelper = OnboardingHelperClass();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: context.read<CreateAccountCubit>().state.name.value.toString(),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
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
              "Welcome!\nWhat do we call you?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),

            OnboardingTextfield(
              labelText: "First name will do perfectly fine",
              hintText: "Name",
              keyboardType: TextInputType.name,
              controller: nameController,
              onChanged: (value) => context
                  .read<CreateAccountCubit>()
                  .updateName(nameController.text.toString()),
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
                                .name
                                .isVisibleToAll ??
                            false,
                        onChanged: (value) {
                          context.read<CreateAccountCubit>().updateName(
                            nameController.text,
                            isVisibleToAll: value ?? false,
                          );
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
      ),
    );
  }
}
