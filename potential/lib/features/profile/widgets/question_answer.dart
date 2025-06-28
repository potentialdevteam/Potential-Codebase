import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/profile/cubit/question_progress_cubit.dart';
import 'package:potential/features/profile/cubit/user_questions_cubit.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/profile/models/question_categories.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class QuestionAnswerPage extends StatefulWidget {
  const QuestionAnswerPage({
    super.key,
    required this.question,
    this.options,
    required this.title,
    required this.titleColor,
    required this.questionIndex,
    this.mcqQuestions,
    required this.category,
  });

  final String question;
  final List<String>? options;
  final String title;
  final Color titleColor;
  final int questionIndex;
  final List<String>? mcqQuestions;
  final QuestionCategory category;

  @override
  State<QuestionAnswerPage> createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  late final TextEditingController answerController;
  String? textAnswer;
  String? mcqAnswer;
  List<bool>? selectedMCQOptions;
  bool isNewAnswer = false;

  void setTextAnswer(String text) {
    textAnswer = text;
  }

  void setMcqAnswer(int index) {
    if (selectedMCQOptions != null) {
      if (selectedMCQOptions![index]) {
        setState(() {
          selectedMCQOptions![index] = !selectedMCQOptions![index];
        });
        return;
      } else {
        if (selectedMCQOptions!.where((element) => element).length == 1) {
          setState(() {
            selectedMCQOptions = List.generate(
              widget.mcqQuestions!.length,
              (index) => false,
            );
            selectedMCQOptions![index] = !selectedMCQOptions![index];
          });
          return;
        }
        setState(() {
          selectedMCQOptions![index] = !selectedMCQOptions![index];
        });
      }
    }
  }

  void saveAnswer(BuildContext context) {
    final isTextAnswerValid =
        textAnswer != null && textAnswer!.trim().isNotEmpty;
    final isMcqAnswerValid =
        selectedMCQOptions != null &&
        selectedMCQOptions!.any((element) => element);

    if (isTextAnswerValid && isMcqAnswerValid) {
      CustomSnackBarHelper.showCustomSnackbar(
        context,
        "Please select either a text answer or MCQ options, not both.",
      );
      return;
    }

    if (isTextAnswerValid) {
      context.read<UserQuestionsCubit>().updateAnswer(
        widget.category,
        widget.questionIndex,
        textAnswer!,
      );
      context.read<QuestionProgressCubit>().updateProgress(
        widget.category,
        isNewAnswer,
      );
      Navigator.pop(context);
      return;
    }

    if (isMcqAnswerValid) {
      String mcqAnswer = "";
      for (int i = 0; i < selectedMCQOptions!.length; i++) {
        if (selectedMCQOptions![i]) {
          mcqAnswer += widget.mcqQuestions![i];
        }
      }

      // save the answer
      context.read<UserQuestionsCubit>().updateAnswer(
        widget.category,
        widget.questionIndex,
        mcqAnswer,
      );
      context.read<QuestionProgressCubit>().updateProgress(
        widget.category,
        isNewAnswer,
      );
      Navigator.pop(context);
      return;
    }

    // No valid answer
    CustomSnackBarHelper.showCustomSnackbar(
      context,
      "Please provide an answer.",
    );
  }

  @override
  void initState() {
    super.initState();
    textAnswer = context
        .read<UserQuestionsCubit>()
        .state
        .userQuestionsData[widget.category.name]![widget.questionIndex]
        .answer;

    setState(() {
      isNewAnswer = textAnswer == null || textAnswer!.trim().isEmpty;
      if (isNewAnswer) {
        textAnswer = "";
      }
    });
    answerController = TextEditingController(text: textAnswer);
    if (widget.mcqQuestions != null) {
      selectedMCQOptions = List.generate(
        widget.mcqQuestions!.length,
        (index) => false,
      );
    }
  }

  @override
  void dispose() {
    answerController.dispose();
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(color: widget.titleColor, fontSize: 25),
            ),
            TextButton(
              onPressed: () => saveAnswer(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.02),
                  side: BorderSide(color: AppColors.accentWhite),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.01,
                ),
              ),
              child: Text(
                "Save",
                style: TextStyle(color: AppColors.accentWhite),
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: BackButtonWidget(),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: width,
          height: height * 0.7,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // MAIN QUESTION
                Hero(
                  tag: widget.question,
                  child: SizedBox(
                    width: width * 0.8,
                    child: Text(
                      widget.question,
                      style: TextStyle(
                        color: AppColors.accentWhite,
                        fontSize: width * 0.05,
                        decoration: TextDecoration.none,
                        fontFamily: "Vastago Grotesk",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                if (widget.mcqQuestions != null)
                  Column(
                    spacing: height * 0.03,
                    children: [
                      // MCQ QUESTIONS
                      Column(
                        children: List.generate(widget.mcqQuestions!.length, (
                          index,
                        ) {
                          return SizedBox(
                            width: width * 0.8,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    widget.mcqQuestions![index],
                                    style: TextStyle(
                                      color: AppColors.accentWhite,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Checkbox(
                                  value: selectedMCQOptions![index],
                                  activeColor: AppColors.accentWhite,
                                  checkColor: AppColors.bgBlack,
                                  onChanged: (value) {
                                    setMcqAnswer(index);
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: height * 0.02),
                      SizedBox(
                        width: width * 0.8,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Divider(color: AppColors.accentWhite),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.02,
                              ),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: AppColors.accentWhite,
                                  fontSize: width * 0.04,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(color: AppColors.accentWhite),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                Container(
                  width: width * 0.8,
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.accentWhite),
                  ),
                  child: TextField(
                    controller: answerController,
                    style: TextStyle(color: AppColors.accentWhite),
                    maxLines: null,
                    maxLength: 150,
                    onChanged: (text) => setTextAnswer(text),
                    decoration: InputDecoration(
                      hintText: "Write Answer Here",
                      counterText: "${answerController.text.length}/150",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
