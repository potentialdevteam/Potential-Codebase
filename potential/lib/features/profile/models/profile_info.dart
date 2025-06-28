import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';

/// Model for a single question answer
///
/// [question] is the question text
/// [answer] is the answer text
/// [isShownOnProfile] is a boolean value that indicates if the question answer is shown on the profile
class UserQuestionAnswerModel {
  String question;
  String answer;
  bool isShownOnProfile;

  UserQuestionAnswerModel({
    required this.answer,
    required this.question,
    required this.isShownOnProfile,
  });
}

/// This model will be used to store the logged-in user's profile information
///
/// [accountData] is the user's account data
/// 
/// [questionAnswers] is a map of question category name to the list of question answers belonging to that category
class UserProfileInfoModel {
  CreateAccountData accountData;

  /// [key] is the question category name
  /// [value] is the list of question answers belonging to that category
  Map<String, List<UserQuestionAnswerModel>> questionAnswers;

  UserProfileInfoModel({
    required this.accountData,
    required this.questionAnswers,
  });
}
