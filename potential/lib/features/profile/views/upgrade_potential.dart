import 'package:flutter/material.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/home/helpers/home_page_helper.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/back_button.dart';

class UpgradePotential extends StatelessWidget {
  const UpgradePotential({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final HomePageHelper homePageHelper = HomePageHelper();

    final List<Map<String, String>> upgradeOptions = [
      {"title": "1 week", "price": "Rs 299/week"},
      {"title": "1 month", "price": "Rs 249/week"},
      {"title": "3 months", "price": "Rs 209/week"},
    ];

    final List<Map<String, String>> upgradePerks = [
      {
        "title": "Increased Connections",
        "subtitle": "Match with more people daily",
      },
      {"title": "Premium Experience", "subtitle": "More features less ads"},
      {
        "title": "Greater Access",
        "subtitle": "Invites to events, courses and more",
      },
    ];

    final String image = "assets/images/potential_woman_face.jpg";

    final List<String> benefits = [
      "Unlimited Daily Likes",
      "Unlimited Daily Appreciations",
      "Unlimited Daily Reserve Profiles",
      "Initiate chat with 3 new users / day",
      "Access to Events and Social Gatherings",
      "Access to Discounted First Date tie ups",
      "2 Complimentary Profile Boosts/Week (30 mins)",
      "Allowed to display all pictures since the start",
      "Advanced Search filters",
      "No ads",
    ];

    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        title: Text(
          "Potential Elevated",
          style: TextStyle(color: AppColors.accentWhite, fontSize: 25),
        ),
        centerTitle: true,
        leading: BackButtonWidget(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Hands Image
            Image.asset(
              "assets/images/holding_hands.jpeg",
              width: width,
              height: height * 0.3,
              fit: BoxFit.cover,
            ),
            // upgrade options
            SizedBox(
              width: width,
              height: height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) {
                  final upgradeOption = upgradeOptions[index];
                  return Container(
                    width: width * 0.25,
                    height: width * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: width * 0.2,
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.bgBlack,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              upgradeOption["title"]!,
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              upgradeOption["price"]!,
                              style: TextStyle(color: AppColors.soulYellow),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // upgrade perks
            SizedBox(
              width: width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: width * 0.02,
                children: List.generate(upgradePerks.length, (index) {
                  final upgradePerk = upgradePerks[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.accentWhite,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(width * 0.04),
                          color: Colors.transparent,
                          width: width * 0.3,
                          height: width * 0.3,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  width * 0.09,
                                ),
                                child: Image.asset(
                                  image,
                                  width: width * 0.18,
                                  height: width * 0.18,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: width * 0.06,
                                  height: width * 0.06,
                                  decoration: BoxDecoration(
                                    color: AppColors.bgBlack,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.accentWhite,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Text>[
                              Text(
                                upgradePerk["title"]!,
                                style: TextStyle(
                                  color: AppColors.accentWhite,
                                  fontSize: width * 0.04,
                                ),
                              ),
                              Text(
                                upgradePerk["subtitle"]!,
                                style: TextStyle(
                                  color: AppColors.accentWhite,
                                  fontSize: width * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: height * 0.05),
            // Misc
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: width * 0.05,
              children: [
                Container(
                  width: width * 0.5,
                  height: height * 0.07,
                  color: Colors.transparent,
                  padding: EdgeInsets.all(width * 0.02),
                  child: ElevatedButton(
                    onPressed: () async {
                      await homePageHelper.showPopUpWidget(
                        widget: SizedBox(
                          width: width * 0.7,
                          height: height * 0.5,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "All Benefits Listed :",
                                  style: TextStyle(
                                    color: AppColors.soulYellow,
                                    fontSize: width * 0.04,
                                  ),
                                ),
                                SizedBox(height: height * 0.05),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: width * 0.04,
                                  children: List.generate(10, (index) {
                                    return Text(
                                      benefits[index].toString(),
                                      style: TextStyle(
                                        color: AppColors.accentWhite,
                                        fontSize: width * 0.04,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        context: context,
                        borderColor: AppColors.accentRed,
                        backgroundColor: AppColors.bgBlack.withAlpha(100),
                        isBackDropFilter: true,
                      );
                    },
                    child: Text(
                      "All Benefits",
                      style: TextStyle(
                        color: AppColors.bgBlack,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Includes all that Potential has to offer",
                  style: TextStyle(
                    color: AppColors.accentWhite,
                    fontSize: width * 0.04,
                  ),
                ),
                OnboardingButton(
                  onPressed: () {},
                  text: "Try 1 week for Rs. 299",
                ),
              ],
            ),

            SizedBox(height: height * 0.1),
          ],
        ),
      ),
    );
  }
}
