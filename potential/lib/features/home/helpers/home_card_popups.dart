import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/home/helpers/home_page_helper.dart';
import 'package:potential/features/home/models/user_model.dart';
import 'package:potential/features/home/widgets/card_question_popup.dart';
import 'package:potential/features/home/widgets/locked_soul_card_popup.dart';

class HomeCardPopups {
  void showCardPopup(
    BuildContext context,
    int index,
    Map<String, dynamic> cardData,
    double width,
    double height,
    bool isSoulCardUnlocked,
    UserModel userModel, {
    bool? showAppreciationIcon = false,
  }) async {
    if (index == 3) {
      // user clicked on soul card
      if (isSoulCardUnlocked) {
        // soul card is unlocked
        return await HomePageHelper().showPopUpWidget(
          widget: CardQuestionPopupWidget(
            questions: userModel.questionAnswers[cardData['cardTitle']] ?? {},
            title: cardData['cardTitle'],
            assetPath: cardData['cardIcon'],
            isSoulCard: cardData['cardTitle'] == "Soul",
            user: userModel,
            showAppreciationIcon: showAppreciationIcon,
          ),
          context: context,
          borderColor: AppColors.accentWhite,
          gradientColors: [
            cardData['cardStartColor'],
            cardData['cardEndColor'],
          ],
          buttonGradientColors: [
            cardData['cardEndColor'],
            cardData['cardStartColor'],
          ],
          isBackDropFilter: false,
          wrapperHeight: height * 0.65,
          wrapperWidth: width * 0.8,
        );
      }
      // soul card is locked
      return await showModalBottomSheet(
        backgroundColor: AppColors.bgBlack.withAlpha(100),
        useSafeArea: true,
        context: context,
        builder: (context) {
          return LockedSoulCardPopup();
        },
      );
    } else {
      return await HomePageHelper().showPopUpWidget(
        widget: CardQuestionPopupWidget(
          questions: userModel.questionAnswers[cardData['cardTitle']] ?? {},
          title: cardData['cardTitle'],
          assetPath: cardData['cardIcon'],
        ),
        context: context,
        borderColor: AppColors.accentWhite,
        gradientColors: [cardData['cardStartColor'], cardData['cardEndColor']],
        buttonGradientColors: [
          cardData['cardEndColor'],
          cardData['cardStartColor'],
        ],
        isBackDropFilter: false,
        wrapperHeight: height * 0.65,
        wrapperWidth: width * 0.8,
      );
    }
  }

  void showLikePopup(
    BuildContext context,
    String cardTitle,
    String name,
    String age,
    Function onLikeTap,
  ) async {
    return await showModalBottomSheet(
      backgroundColor: AppColors.bgBlack.withAlpha(100),
      useSafeArea: true,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name, $age",
                    style: TextStyle(
                      color: AppColors.accentWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.05,
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Do you wish to like their $cardTitle?"),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => onLikeTap(context),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.accentWhite,
                                    AppColors.accentRed,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: AppColors.accentWhite,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: AppColors.accentWhite,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: AppColors.bgBlack,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showSoulChatPopup(
    BuildContext context,
    String name,
    String age,
    String cardTitle,
    String question,
    String answer,
  ) async {
    return await showModalBottomSheet(
      backgroundColor: AppColors.bgBlack.withAlpha(100),
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.1,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name, $age",
                      style: TextStyle(
                        color: AppColors.accentWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 255, 229, 83),
                            const Color.fromARGB(255, 221, 188, 3),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.accentWhite,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: MediaQuery.of(context).size.height * 0.02,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02,
                            ),
                            child: Text(
                              question,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02,
                            ),
                            child: Text(
                              answer,
                              style: TextStyle(
                                color: AppColors.accentWhite,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Send an Appreciation",
                        hintStyle: TextStyle(color: AppColors.bgBlack),
                        fillColor: AppColors.accentWhite,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.08,
                          ),
                          borderSide: BorderSide(color: AppColors.accentWhite),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.accentWhite),
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.accentWhite),
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.accentWhite,
                                AppColors.accentRed,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Send",
                              style: TextStyle(
                                color: AppColors.accentWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: AppColors.accentWhite,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: AppColors.bgBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
