import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';

class ProfileSocialHandle extends StatefulWidget {
  const ProfileSocialHandle({super.key});

  @override
  State<ProfileSocialHandle> createState() => _ProfileSocialHandleState();
}

class _ProfileSocialHandleState extends State<ProfileSocialHandle> {
  late TextEditingController socialHandleController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socialHandleController = TextEditingController(
      text: context
          .read<CreateAccountCubit>()
          .state
          .socialMediaHandle
          .value
          .toString(),
    );
  }

  @override
  void dispose() {
    socialHandleController.dispose();
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
              "Drop you social handle",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),

            OnboardingTextfield(
              labelText: "Any of you social handles will do",
              hintText: "Example : @productive_pod",
              keyboardType: TextInputType.number,
              controller: socialHandleController,
              onChanged: (value) => context
                  .read<CreateAccountCubit>()
                  .updateSocialMediaHandle(value),
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
                            .socialMediaHandle
                            .isVisibleToAll ??
                        false,
                    onChanged: (value) {
                      context
                          .read<CreateAccountCubit>()
                          .updateSocialMediaHandle(
                            socialHandleController.text,
                            isVisibleToAll:
                                value ??
                                context
                                    .watch<CreateAccountCubit>()
                                    .state
                                    .socialMediaHandle
                                    .isVisibleToAll,
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
