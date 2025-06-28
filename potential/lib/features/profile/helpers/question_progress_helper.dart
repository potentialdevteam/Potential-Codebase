import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/profile/cubit/user_questions_cubit.dart';

class QuestionProgressHelper {
  static getQuestionsProgress(BuildContext context) {
    if (context.mounted) {
      final Map<String, dynamic> questionsProgress = context
          .read<UserQuestionsCubit>()
          .getAllAnsweredQuestions();
      return {
        "sparkProgress": questionsProgress["Spark"]!,
        "mindProgress": questionsProgress["Mind"]!,
        "heartProgress": questionsProgress["Heart"]!,
        "soulProgress": questionsProgress["Soul"]!,
      };
    }
  }
}
