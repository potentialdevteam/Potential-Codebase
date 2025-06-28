import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potential/core/configs/theme_extention.dart';
import 'package:potential/features/profile/cubit/question_progress_cubit.dart';
import 'package:potential/features/profile/helpers/question_progress_helper.dart';
import 'package:potential/features/profile/helpers/settings_helper.dart';
import 'package:potential/features/profile/service/logout.dart';
import 'package:potential/features/profile/widgets/potential_elevated.dart';
import 'package:potential/features/profile/widgets/potential_purchases.dart';
import 'package:potential/features/profile/widgets/user_profile_pic_completion.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/features/profile/helpers/question_card_helper.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/profile/views/update_profile.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/basic_card_layout.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    final QuestionProgressState state = QuestionProgressState.fromJson(
      QuestionProgressHelper.getQuestionsProgress(context),
    );
    context.read<QuestionProgressCubit>().updateProgressState(state);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        title: SizedBox(
          width: width,
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/svg/app_logo.svg",
                height: height * 0.04,
                width: height * 0.04,
              ),
              Center(
                child: Text(
                  "Profile",
                  style: TextStyle(color: AppColors.accentWhite, fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User Profile Picture
              UserProfilePictureCompletion(
                width: width,
                height: height,
                onTap: () {
                  Navigator.push(
                    context,
                    FadeRouteTransition(dest: const UpdateProfileScreen()),
                  );
                },
              ),

              BlocBuilder<CreateAccountCubit, CreateAccountData>(
                builder: (context, state) {
                  return Text(
                    "${state.name.value}, ${state.age.value}",
                    style: TextStyle(
                      color: AppColors.accentWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  );
                },
              ),
              SizedBox(height: height * 0.02),
              Divider(
                color: AppColors.accentRed,
                thickness: 2,
                endIndent: width * 0.08,
                indent: width * 0.08,
                radius: BorderRadius.circular(10),
              ),
              SizedBox(height: height * 0.02),
              Text(
                "YOUR CARDS",
                style: TextStyle(
                  color: AppColors.accentWhite,
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),

              // 4 Cards
              Column(
                children: List.generate(4, (index) {
                  final card = CardsHelperClass.cardModelS[index];
                  return BasicCardLayout(
                    cardModel: card,
                    isSoulCardUnlocked: true,
                    isSoulCard: index == 3,
                    overlayWidget: BlocBuilder<QuestionProgressCubit, QuestionProgressState>(
                      builder: (context, state) {
                        return Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            width: width * 0.15,
                            height: width * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accentWhite,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  backgroundColor: Colors.transparent,
                                  color:
                                      card.progressColor ??
                                      AppColors.sparkPurple,
                                  value: card.cardTitle == "Spark"
                                      ? (context
                                                .watch<QuestionProgressCubit>()
                                                .state
                                                .sparkProgress
                                                .progress /
                                            10.0)
                                      : card.cardTitle == "Mind"
                                      ? (context
                                                .watch<QuestionProgressCubit>()
                                                .state
                                                .sparkProgress
                                                .progress /
                                            10.0)
                                      : card.cardTitle == "Heart"
                                      ? (context
                                                .watch<QuestionProgressCubit>()
                                                .state
                                                .sparkProgress
                                                .progress /
                                            10.0)
                                      : (context
                                                .watch<QuestionProgressCubit>()
                                                .state
                                                .sparkProgress
                                                .progress /
                                            10.0),
                                  strokeWidth: 1,
                                  padding: EdgeInsets.all(5),
                                ),

                                Text(
                                  card.cardTitle == "Spark"
                                      ? "${(context.watch<QuestionProgressCubit>().state.sparkProgress.progress * 10)}%"
                                      : card.cardTitle == "Mind"
                                      ? "${(context.watch<QuestionProgressCubit>().state.mindProgress.progress * 10)}%"
                                      : card.cardTitle == "Heart"
                                      ? "${(context.watch<QuestionProgressCubit>().state.heartProgress.progress * 10)}%"
                                      : "${(context.watch<QuestionProgressCubit>().state.soulProgress.progress * 10)}%",
                                  style: TextStyle(
                                    color: AppColors.bgBlack,
                                    fontSize: width * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    onCardTap: () {
                      CardsHelperClass.getNavigationByCardTitle(
                        card.cardTitle,
                        context,
                        card,
                      );
                    },
                  );
                }),
              ),

              SizedBox(height: height * 0.02),
              Divider(
                color: AppColors.accentRed,
                thickness: 2,
                endIndent: width * 0.08,
                indent: width * 0.08,
                radius: BorderRadius.circular(10),
              ),
              SizedBox(height: height * 0.02),
              Text(
                "UNLOCK YOUR POTENTIAL",
                style: TextStyle(
                  color: AppColors.accentWhite,
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),

              // Potential Elevated
              PotentialElevated(width: width, height: height),

              // Premium Purchase Options
              Container(
                width: width * 0.9,
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <PotentialPurchases>[
                    PotentialPurchases(
                      purchaseName: "Likes",
                      purchaseCountAvailable: 0,
                      purchaseIcon: Icons.heart_broken,
                    ),
                    PotentialPurchases(
                      purchaseName: "Boosts",
                      purchaseCountAvailable: 0,
                      purchaseIcon: Icons.thunderstorm,
                    ),
                    PotentialPurchases(
                      purchaseName: "Appreciation",
                      purchaseCountAvailable: 0,
                      purchaseIcon: Icons.message_sharp,
                    ),
                  ],
                ),
              ),

              // Unlock YOur Potential Text
              SizedBox(height: height * 0.02),
              Divider(
                color: AppColors.accentRed,
                thickness: 2,
                endIndent: width * 0.08,
                indent: width * 0.08,
                radius: BorderRadius.circular(10),
              ),
              SizedBox(height: height * 0.02),
              Text(
                "ADDITIONAL SETTINGS",
                style: TextStyle(
                  color: AppColors.accentWhite,
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),

              // User Settings (account , dark mode ... security)
              SizedBox(
                width: width * 0.9,
                child: Column(
                  children: List.generate(SettingsHelper.userSettings.length, (
                    index,
                  ) {
                    final key = SettingsHelper.userSettings.keys
                        .toList()[index];
                    final page = SettingsHelper.userSettings[key];
                    return InkWell(
                      splashColor: context.colors.grey,
                      onTap: () {
                        Navigator.push(
                          context,
                          FadeRouteTransition(dest: page!),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsetsGeometry.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              key,
                              style: TextStyle(
                                color: Colors.grey[350],
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: AppColors.accentWhite,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // User Settings (what's new, faq, terms of service, privacy policy)
              SizedBox(
                width: width * 0.9,
                child: Column(
                  children: List.generate(SettingsHelper.userSettings2.length, (
                    index,
                  ) {
                    final key = SettingsHelper.userSettings2.keys
                        .toList()[index];
                    final page = SettingsHelper.userSettings2[key];
                    return InkWell(
                      splashColor: context.colors.grey,
                      onTap: () {
                        Navigator.push(
                          context,
                          FadeRouteTransition(dest: page!),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              key,
                              style: TextStyle(
                                color: Colors.grey[350],
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: AppColors.accentWhite,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Logout Button
              SizedBox(
                width: width * 0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: AppColors.accentRed, width: 1),
                    ),
                    backgroundColor: context.colors.grey,
                  ),
                  onPressed: () => LogoutService().logout(context),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: AppColors.accentWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
