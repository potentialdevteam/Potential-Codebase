import 'package:potential/features/profile/cubit/user_questions_cubit.dart';

class QuestionAnswerController {

  // get user's saved questions and answers
  getUserQuestionAnswers(String email) {
    return UserQuestionState.initialState();
  }
}
