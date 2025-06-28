import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/profile/cubit/updatable_fields.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class UpdateFirstMoveScreen extends StatefulWidget {
  const UpdateFirstMoveScreen({super.key});

  @override
  State<UpdateFirstMoveScreen> createState() => _UpdateFirstMoveScreenState();
}

class _UpdateFirstMoveScreenState extends State<UpdateFirstMoveScreen> {
  late TextEditingController firstMoveController;

  @override
  void initState() {
    super.initState();
    firstMoveController = TextEditingController(
      text: context.read<CreateAccountCubit>().state.firstMove.toString(),
    );
  }

  @override
  void dispose() {
    firstMoveController.dispose();
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
                  "First Move",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),

                OnboardingTextfield(
                  labelText: "Enter your first move",
                  hintText: "Example : Dine in or Takeout ?",
                  keyboardType: TextInputType.text,
                  controller: firstMoveController,
                  onChanged: (value) {
                    context.read<UpdatableFieldsCubit>().updateFirstMove(value);
                  },
                ),

                Text(
                  "This is an optional field.",
                  style: TextStyle(color: AppColors.accentWhite),
                ),

                OnboardingButton(
                  onPressed: () {
                    if (firstMoveController.text.isEmpty) {
                      CustomSnackBarHelper.showCustomSnackbar(
                        context,
                        "Please enter your first move",
                      );
                    } else {
                      context.read<UpdatableFieldsCubit>().updateFirstMove(
                        firstMoveController.text,
                      );
                      context.read<CreateAccountCubit>().updateFirstMove(
                        firstMoveController.text,
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
    final updatableFieldsState = context.read<UpdatableFieldsCubit>().state;
    final createAccountState = context.read<CreateAccountCubit>().state;

    if (updatableFieldsState.firstMove != createAccountState.firstMove) {
      return CustomSnackBarHelper.showCustomSnackbar(
        context,
        "You have unsaved changes.",
      );
    }

    Navigator.pop(context);
  }
}
