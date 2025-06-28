import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/core/configs/theme_extention.dart';
import 'package:potential/features/home/helpers/home_page_helper.dart';
import 'package:potential/features/profile/models/card_info_popup.dart';
import 'package:potential/features/profile/models/question_categories.dart';
import 'package:potential/features/profile/widgets/card_info_popup.dart';
import 'package:potential/features/profile/widgets/question_answer.dart';
import 'package:potential/features/profile/cubit/user_questions_cubit.dart';
import 'package:potential/features/profile/helpers/question_card_helper.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CardQuestionPage extends StatefulWidget {
  const CardQuestionPage({
    super.key,
    required this.title,
    required this.yourPotentialTitle,
    required this.titleColor,
    required this.questions,
    required this.yourPotential,
    this.titleStartColor,
    this.titleEndColor,
  });

  final String title;
  final String yourPotentialTitle;
  final Color titleColor;
  final List<String> questions;
  final List<String> yourPotential;
  final Color? titleStartColor;
  final Color? titleEndColor;

  @override
  State<CardQuestionPage> createState() => _CardQuestionPageState();
}

class _CardQuestionPageState extends State<CardQuestionPage> {
  int currentPage = 0;
  late final PageController pageController;

  // user can only select a maximum of 3 questions
  late List<bool> selectedQuestions;

  late CardInfoPopupModel categoryInfo;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
    selectedQuestions = List.generate(
      widget.questions.length,
      (index) => false,
    );

    categoryInfo = CardsHelperClass.getCardPopUpInfoByCategory(
      getQuestionCategory(),
      context,
    );
  }

  void selectQuestionToShowOnProfile(int index, BuildContext context) {
    // maximum of 3 questions can be selected
    if (selectedQuestions.where((element) => element).length >= 3) {
      // if user has selected the question before then remove it
      if (selectedQuestions[index]) {
        setState(() {
          selectedQuestions[index] = !selectedQuestions[index];
        });
        context.read<UserQuestionsCubit>().toggleShowOnProfile(
          getQuestionCategory(),
          index,
        );
      } // if user has not selected the question before then show a snackbar to the user
      else {
        CustomSnackBarHelper.showCustomSnackbar(
          context,
          "You can only select a maximum of 3 questions.",
        );
      }
    }
    // if user wants to select a question
    else {
      setState(() {
        selectedQuestions[index] = !selectedQuestions[index];
      });

      context.read<UserQuestionsCubit>().toggleShowOnProfile(
        getQuestionCategory(),
        index,
      );
    }
  }

  QuestionCategory getQuestionCategory() {
    switch (widget.title) {
      case "Spark":
        return QuestionCategory.spark;
      case "Mind":
        return QuestionCategory.mind;
      case "Heart":
        return QuestionCategory.heart;
      case "Soul":
        return QuestionCategory.soul;
      default:
        return QuestionCategory.spark;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        title: GradientText(
          widget.title,
          colors: [
            widget.titleStartColor ?? widget.titleColor,
            widget.titleEndColor ?? widget.titleColor,
          ],
          gradientDirection: GradientDirection.ttb,
          style: TextStyle(
            color: widget.titleColor,
            fontSize: width * 0.07,
            fontWeight: FontWeight.bold,
            fontFamily: "Vastago Grotesk",
          ),
        ),
        centerTitle: true,
        leading: BackButtonWidget(),
        actions: [
          IconButton(
            onPressed: () async {
              await HomePageHelper().showPopUpWidget(
                context: context,
                widget: CardInfoPopup(
                  assetPath: categoryInfo.assetPath,
                  texts: categoryInfo.infoText,
                  notes: categoryInfo.infoNotes,
                  noteTextColor: categoryInfo.noteTextColor,
                ),
                wrapperHeight: height * 0.8,
                wrapperWidth: width * 0.8,
                isBackDropFilter: false,
                borderColor: categoryInfo.noteTextColor,
                backgroundColor: AppColors.bgBlack,
                buttonGradientColors: categoryInfo.gradientColors,
              );
            },
            icon: Icon(
              Icons.info_outline_rounded,
              color: widget.titleColor,
              size: width * 0.07,
            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          children: [
            Container(
              width: width * 0.6,
              height: height * 0.06,
              decoration: BoxDecoration(
                color: context.colors.grey,
                borderRadius: BorderRadius.circular(height * 0.03),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPage = 0;
                      });
                      pageController.animateToPage(
                        currentPage,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: currentPage == 0
                            ? AppColors.accentWhite
                            : Colors.grey,
                        fontSize: width * 0.05,
                      ),
                    ),
                  ),
                  // vertical line
                  Container(
                    width: 1,
                    height: height * 0.05,
                    color: AppColors.accentWhite,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPage = 1;
                      });
                      pageController.animateToPage(
                        currentPage,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      "Your Potential",
                      style: TextStyle(
                        color: currentPage == 1
                            ? AppColors.accentWhite
                            : Colors.grey,
                        fontSize: width * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                allowImplicitScrolling: false,
                pageSnapping: true,
                onPageChanged: (value) => setState(() {
                  currentPage = value;
                }),
                children: [
                  // QUESTIONS PAGE
                  Container(
                    height: height * 0.7,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(height * 0.03),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // TITLE
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                            ),
                            child: Text(
                              "Select 3 you wish to display",
                              style: TextStyle(
                                color: AppColors.accentWhite,
                                fontSize: width * 0.045,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          // LIST OF QUESTIONS
                          Column(
                            children: List.generate(widget.questions.length, (
                              index,
                            ) {
                              return InkWell(
                                splashColor: widget.titleColor,
                                onTap: () => Navigator.push(
                                  context,
                                  FadeRouteTransition(
                                    dest: QuestionAnswerPage(
                                      question: widget.questions[index]
                                          .toString(),
                                      title: widget.title,
                                      titleColor: widget.titleColor,
                                      questionIndex: index,
                                      mcqQuestions: widget.title == "Mind"
                                          ? CardsHelperClass
                                                .MindMCQQuestions[index]
                                          : widget.title == "Heart"
                                          ? CardsHelperClass
                                                .HeartMCQQuestions[index]
                                          : null,
                                      category: getQuestionCategory(),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: width * 0.85,
                                  height: height * 0.085,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Hero(
                                                tag: widget.questions[index],
                                                child: Text(
                                                  widget.questions[index],
                                                  style: TextStyle(
                                                    color: context
                                                        .colors
                                                        .secondaryWhite,
                                                    fontSize: width * 0.04,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily:
                                                        "Vastago Grotesk",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ),
                                            // CHECKBOX TO SELECT QUESTION TO SHOW ON PROFILE
                                            BlocBuilder<
                                              UserQuestionsCubit,
                                              UserQuestionState
                                            >(
                                              builder: (context, state) {
                                                return Checkbox(
                                                  value: state
                                                      .userQuestionsData[getQuestionCategory()
                                                          .name]![index]
                                                      .isShownOnProfile,
                                                  onChanged: (bool? value) {
                                                    selectQuestionToShowOnProfile(
                                                      index,
                                                      context,
                                                    );
                                                  },
                                                  activeColor: context
                                                      .colors
                                                      .secondaryWhite,
                                                  checkColor: AppColors.bgBlack,
                                                  side: BorderSide(
                                                    color: context
                                                        .colors
                                                        .secondaryWhite,
                                                    width: 2,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppColors.accentWhite,
                                        thickness: 1,
                                        height: height * 0.01,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // YOUR POTENTIAL PAGE
                  Container(
                    height: height * 0.7,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(height * 0.03),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //TITLE
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                            ),
                            child: Text(
                              widget.yourPotentialTitle,
                              style: TextStyle(
                                color: AppColors.accentWhite,
                                fontSize: width * 0.045,
                              ),
                            ),
                          ),

                          // LIST OF YOUR POTENTIALS
                          Column(
                            children: List.generate(
                              widget.yourPotential.length,
                              (index) {
                                return Container(
                                  width: width * 0.85,
                                  height: height * 0.09,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.yourPotential[index],
                                          style: TextStyle(
                                            color: AppColors.accentWhite,
                                            fontSize: width * 0.04,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      Divider(
                                        color: AppColors.accentWhite,
                                        thickness: 1,
                                        height: height * 0.01,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _getCardInfoPopUpWidget(
  //   BuildContext context,
  //   Widget child,
  //   double width,
  //   double height, {
  //   List<Color>? gradient,
  //   double? wrapperHeight,
  //   double? wrapperWidth,
  // }) async {
  //   await showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Colors.transparent,
  //         child: ClipRRect(
  //           borderRadius: BorderRadiusGeometry.circular(20),
  //           child: Container(
  //             width: wrapperWidth ?? width * 0.7,
  //             height: wrapperHeight ?? height * 0.65,
  //             padding: const EdgeInsets.all(20),
  //             decoration: BoxDecoration(
  //               color: AppColors.bgBlack,
  //               borderRadius: BorderRadius.circular(20),
  //               border: Border.all(color: AppColors.accentWhite),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 child,
  //                 GestureDetector(
  //                   onTap: () => Navigator.of(context).pop(),
  //                   child: Container(
  //                     padding: const EdgeInsets.all(2),
  //                     margin: const EdgeInsets.all(10),
  //                     decoration: BoxDecoration(
  //                       // color: AppColors.accentRed,
  //                       gradient: LinearGradient(
  //                         colors:
  //                             gradient ??
  //                             [AppColors.accentRed, AppColors.accentWhite],
  //                         begin: Alignment.topLeft,
  //                         end: Alignment.bottomRight,
  //                       ),
  //                       shape: BoxShape.circle,
  //                     ),
  //                     child: const Icon(
  //                       Icons.close,
  //                       color: Colors.white,
  //                       size: 25,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
