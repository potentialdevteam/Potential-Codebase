import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/profile/cubit/updatable_fields.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class UpdateWorkScreen extends StatefulWidget {
  const UpdateWorkScreen({super.key});

  @override
  State<UpdateWorkScreen> createState() => _UpdateWorkScreenState();
}

class _UpdateWorkScreenState extends State<UpdateWorkScreen> {
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
                  keyboardType: TextInputType.text,
                  controller: workController,
                  onChanged: (value) {
                    context.read<UpdatableFieldsCubit>().updateWorkExperience(
                      value,
                    );
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
                                .watch<UpdatableFieldsCubit>()
                                .state
                                .workExperience
                                .isVisibleToAll ??
                            false,
                        onChanged: (value) {
                          context
                              .read<UpdatableFieldsCubit>()
                              .updateWorkExperience(
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

                OnboardingButton(
                  onPressed: () {
                    if (workController.text.isEmpty) {
                      CustomSnackBarHelper.showCustomSnackbar(
                        context,
                        "Please enter your workplace",
                      );
                    } else {
                      context.read<UpdatableFieldsCubit>().updateWorkExperience(
                        workController.text,
                      );
                      context.read<CreateAccountCubit>().updateWorkExperience(
                        workController.text,
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
      ),
    );
  }

  _goBack(BuildContext context) {
    if (context
        .read<UpdatableFieldsCubit>()
        .state
        .workExperience
        .value
        .isEmpty) {
      return CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Please enter your workplace",
      );
    }
    if (context.read<UpdatableFieldsCubit>().state.workExperience.value !=
            context.read<CreateAccountCubit>().state.workExperience.value ||
        context
                .read<UpdatableFieldsCubit>()
                .state
                .workExperience
                .isVisibleToAll !=
            context
                .read<CreateAccountCubit>()
                .state
                .workExperience
                .isVisibleToAll) {
      return CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Please save your changes.",
      );
    }
    Navigator.pop(context);
  }
}
