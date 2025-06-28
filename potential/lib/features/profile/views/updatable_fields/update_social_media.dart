import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/profile/cubit/updatable_fields.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class UpdateSocialMediaScreen extends StatefulWidget {
  const UpdateSocialMediaScreen({super.key});

  @override
  State<UpdateSocialMediaScreen> createState() =>
      _UpdateSocialMediaScreenState();
}

class _UpdateSocialMediaScreenState extends State<UpdateSocialMediaScreen> {
  late TextEditingController socialMediaController;

  @override
  void initState() {
    super.initState();
    socialMediaController = TextEditingController(
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
    socialMediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        leading: BackButtonWidget(onPressed: () => _goBack(context)),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                  "Social Media Handle",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),

                OnboardingTextfield(
                  labelText: "Enter your social media handle",
                  hintText: "Example : @john_doe",
                  keyboardType: TextInputType.text,
                  controller: socialMediaController,
                  onChanged: (value) {
                    context
                        .read<UpdatableFieldsCubit>()
                        .updateSocialMediaHandle(value);
                  },
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value:
                            context
                                .watch<UpdatableFieldsCubit>()
                                .state
                                .socialMediaHandle
                                .isVisibleToAll ??
                            false,
                        onChanged: (value) {
                          context
                              .read<UpdatableFieldsCubit>()
                              .updateSocialMediaHandle(
                                socialMediaController.text,
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

                OnboardingButton(
                  onPressed: () {
                    if (socialMediaController.text.isEmpty) {
                      CustomSnackBarHelper.showCustomSnackbar(
                        context,
                        "Please enter your social media handle",
                      );
                    } else {
                      context
                          .read<UpdatableFieldsCubit>()
                          .updateSocialMediaHandle(socialMediaController.text);
                      context
                          .read<CreateAccountCubit>()
                          .updateSocialMediaHandle(socialMediaController.text);
                      Navigator.pop(context);
                    }
                  },
                  text: "Save",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _goBack(BuildContext context) {
    final updatableFieldsState = context.read<UpdatableFieldsCubit>().state;
    final createAccountState = context.read<CreateAccountCubit>().state;

    if (updatableFieldsState.socialMediaHandle.value !=
            createAccountState.socialMediaHandle.value ||
        updatableFieldsState.socialMediaHandle.isVisibleToAll !=
            createAccountState.socialMediaHandle.isVisibleToAll) {
      return CustomSnackBarHelper.showCustomSnackbar(
        context,
        " Please save your changes.",
      );
    }

    Navigator.pop(context);
  }
}
