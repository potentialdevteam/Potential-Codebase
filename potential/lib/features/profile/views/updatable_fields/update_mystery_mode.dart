import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/features/onboarding/views/mystery_mode.dart';
import 'package:potential/features/profile/cubit/updatable_fields.dart';
import 'package:potential/shared/widgets/back_button.dart';

class UpdateMysteryModeScreen extends StatelessWidget {
  const UpdateMysteryModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        leading: BackButtonWidget(),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CreateAccountCubit, CreateAccountData>(
              builder: (context, state) {
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Mystery Mode ",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: state.mysteryModeEnabled
                            ? " Enabled"
                            : " Disabled",
                        style: TextStyle(
                          color: state.mysteryModeEnabled
                              ? AppColors.soulYellow
                              : AppColors.accentRed,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            BlocBuilder<CreateAccountCubit, CreateAccountData>(
              builder: (context, state) {
                return Switch.adaptive(
                  activeColor: const Color.fromARGB(255, 255, 255, 255),
                  activeTrackColor: AppColors.soulYellow,
                  inactiveTrackColor: AppColors.accentRed,
                  inactiveThumbColor: AppColors.accentWhite,
                  value: context
                      .read<CreateAccountCubit>()
                      .state
                      .mysteryModeEnabled,
                  onChanged: (value) {
                    context.read<CreateAccountCubit>().updateMysteryModeEnabled(
                      value,
                    );
                    context
                        .read<UpdatableFieldsCubit>()
                        .updateMysteryModeEnabled(value);
                  },
                );
              },
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don't know what mystery mode is? ",
                    style: TextStyle(color: AppColors.accentWhite),
                  ),
                  TextSpan(
                    text: "Learn more",
                    style: TextStyle(
                      color: AppColors.soulYellow,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          FadeRouteTransition(dest: MysterModePage()),
                        );
                      },
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
