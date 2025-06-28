import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';

class ProfileLocation extends StatefulWidget {
  const ProfileLocation({super.key});

  @override
  State<ProfileLocation> createState() => _ProfileLocationState();
}

class _ProfileLocationState extends State<ProfileLocation> {
  late TextEditingController locationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationController = TextEditingController(
      text: context.read<CreateAccountCubit>().state.location.value.toString(),
    );
  }

  @override
  void dispose() {
    locationController.dispose();
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
              "Which part of the world are you present at?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),

            OnboardingTextfield(
              labelText: "Enter your location",
              hintText: "Example : Mumbai",
              keyboardType: TextInputType.name,
              controller: locationController,
              onChanged: (value) {
                context.read<CreateAccountCubit>().updateLocation(value);
              },
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
                            .location
                            .isVisibleToAll ??
                        false,
                    onChanged: (value) {
                      context.read<CreateAccountCubit>().updateLocation(
                        locationController.text,
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
