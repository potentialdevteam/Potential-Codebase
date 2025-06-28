import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:potential/features/profile/models/question_categories.dart';

class StaticQuestions {
  static const Map<QuestionCategory, List<String>> questions = {
    QuestionCategory.spark: [
      "Where's my dream vacation destination?",
      "If I was an ice cream, what flavor would I be?",
      "Am I an early bird or a night owl?",
      "Pet preference - Dogs VS Cats?",
      "Which fictional character do I relate to most?",
      "The worst joke I have ever heard?",
      "What would my last meal be?",
      "Something simple that would make me smile...",
      "My favourite music era is...",
      "An unpopular opinion I have is...",
    ],
    QuestionCategory.mind: [
      "My biggest flaw is...",
      "Traditional gender roles in a relationship?",
      "How future oriented am I?",
      "My thoughts on second chances...",
      "Fate or Freewill?",
      "Am I religious?",
      "A promise I made to myself...",
      "A belief I hold strongly is that...",
      "Importance of my partner's financial success is...",
      "Do I believe opposites attract?",
    ],

    QuestionCategory.heart: [
      "What does Love Mean to Me?",
      "What's One Thing I am Really Proud of?",
      "How Important is a Person's Past for Building a Future?",
      "When Was the Last Time I Cried?",
      "What am I Currently Seeking in Life?",
      "What Does an Ideal First Date Look Like for Me?",
      "What Do I Prioritize in a Partner?",
      "My Views on Having Children?",
      "Am I Willing to Compromise?",
      "What Does an Ideal Day with My Partner Look Like?",
    ],
    QuestionCategory.soul: [
      "Do I believe in soulmates?",
      "How Would I Describe the Kind of Person I Want to End Up With?",
      "What am I Hoping to Find or Achieve through Potential?",
      "What Does the Purpose of Life Look Like for Me?",
      "What's the Most Important Lesson Life Has Taught Me?",
      "How Do I Define Intimacy in a Relationship?",
      "What's My Idea of Hitting Rock Bottom and How Do I Bounce Back in Such a Situation?",
      "Of All the Options Out There, How Do I Wish to Stand Out as a Partner?",
      "What's My Definition of Happiness, and How Do I Pursue It in Life",
      "\"Making It in Life\"\n for Me Would Look Like...",
    ],
  };
}

///This model stores the structure of a single [question] and [answer]
///It also contains a boolean flag [isShownOnProfile] to check if the question is shown on the profile
class UserQuestionModel extends Equatable {
  final String question;
  final String? answer;
  final bool isShownOnProfile;

  const UserQuestionModel({
    required this.question,
    this.answer,
    this.isShownOnProfile = false,
  });

  UserQuestionModel copyWith({String? answer, bool? isShownOnProfile}) {
    return UserQuestionModel(
      question: question,
      answer: answer ?? this.answer,
      isShownOnProfile: isShownOnProfile ?? this.isShownOnProfile,
    );
  }

  @override
  List<Object?> get props => [question, answer, isShownOnProfile];

  factory UserQuestionModel.fromJson(Map<String, dynamic> json) {
    return UserQuestionModel(
      question: json['question'] as String,
      answer: json['answer'] as String?,
      isShownOnProfile: json['isShownOnProfile'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'isShownOnProfile': isShownOnProfile,
    };
  }
}

/// The main state of the structure that holds the user's questions and answers
/// [userQuestionsData] is a map of [QuestionCategory.name] and a list of [UserQuestionModel]
/// [UserQuestionModel] is the question and answer for the category
class UserQuestionState extends Equatable {
  final Map<String, List<UserQuestionModel>> userQuestionsData;

  const UserQuestionState({required this.userQuestionsData});

  UserQuestionState copyWith({
    Map<String, List<UserQuestionModel>>? userQuestionsData,
  }) {
    return UserQuestionState(
      userQuestionsData: userQuestionsData ?? this.userQuestionsData,
    );
  }

  static UserQuestionState initialState() {
    return UserQuestionState(
      userQuestionsData: {
        for (var category in QuestionCategory.values)
          category.name: List.generate(
            StaticQuestions.questions[category]!.length,
            (index) => UserQuestionModel(
              question: StaticQuestions.questions[category]![index],
              answer: null,
              isShownOnProfile: false,
            ),
          ),
      },
    );
  }

  factory UserQuestionState.fromJson(Map<String, dynamic> json) {
    final rawData = json['userQuestionsData'] as Map<String, dynamic>;

    final parsedData = rawData.map((key, value) {
      final questionList = (value as List<dynamic>)
          .map((e) => UserQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return MapEntry(key, questionList);
    });

    return UserQuestionState(userQuestionsData: parsedData);
  }

  Map<String, dynamic>? toJson() {
    return {
      'userQuestionsData': userQuestionsData.map(
        (category, questions) => MapEntry(
          category,
          questions.map((question) => question.toJson()).toList(),
        ),
      ),
    };
  }

  @override
  List<Object?> get props => [userQuestionsData];

  @override
  String toString() {
    return userQuestionsData.toString();
  }
}

/// cubit to manage the user questions and answers
class UserQuestionsCubit extends HydratedCubit<UserQuestionState> {
  UserQuestionsCubit() : super(UserQuestionState.initialState());

  /// update the answer for a specific question
  /// [category] - the category of the question
  /// [index] - the index of the question
  /// [newAnswer] - the new answer to the question
  void updateAnswer(QuestionCategory category, int index, String newAnswer) {
    // fetch the current user question model
    UserQuestionModel currentUserQuestionModel =
        state.userQuestionsData[category.name]![index];

    // update the answer to the new answer
    final updatedUserQuestionModel = currentUserQuestionModel.copyWith(
      answer: newAnswer,
    );

    // fetch the list of user question models for the category
    final updatedList = List<UserQuestionModel>.from(
      state.userQuestionsData[category.name]!,
    );

    // update the list index with the new user question model
    updatedList[index] = updatedUserQuestionModel;

    // emit the new state
    emit(
      state.copyWith(
        userQuestionsData: {
          ...state.userQuestionsData,
          category.name: updatedList,
        },
      ),
    );
  }

  /// toggle the show on profile for a specific question
  /// [category] - the category of the question
  /// [index] - the index of the question
  void toggleShowOnProfile(QuestionCategory category, int index) {
    // fetch the current user question model
    UserQuestionModel currentUserQuestionModel =
        state.userQuestionsData[category.name]![index];

    // update the isShownOnProfile to the opposite of the current value
    final updatedUserQuestionModel = currentUserQuestionModel.copyWith(
      isShownOnProfile: !currentUserQuestionModel.isShownOnProfile,
    );

    // fetch the list of user question models for the category
    final updatedList = List<UserQuestionModel>.from(
      state.userQuestionsData[category.name]!,
    );

    // update the list index with the new user question model
    updatedList[index] = updatedUserQuestionModel;

    // emit the new state
    emit(
      state.copyWith(
        userQuestionsData: {
          ...state.userQuestionsData,
          category.name: updatedList,
        },
      ),
    );
  }

  void displaySelectedQuestionsAndAnswers() {
    final userQuestionAnswerState = state.userQuestionsData;

    for (var entry in userQuestionAnswerState.entries) {
      final String category = entry.key;
      final List<UserQuestionModel> userQuestionModels = entry.value;
      for (UserQuestionModel userModel in userQuestionModels) {
        if (userModel.isShownOnProfile) {
          log(
            "$category = ${userModel.question} || Answer = ${userModel.answer} || IsShownOnProfile = ${userModel.isShownOnProfile}",
          );
        }
      }
    }
  }

  Map<String, dynamic> getAllAnsweredQuestions() {
    final userQuestionAnswerState = state.userQuestionsData;

    Map<String, dynamic> answeredQuestions = {
      "Spark": {"progress": 0},
      "Mind": {"progress": 0},
      "Heart": {"progress": 0},
      "Soul": {"progress": 0},
    };

    for (var entry in userQuestionAnswerState.entries) {
      final String category = entry.key;
      final List<UserQuestionModel> userQuestionModels = entry.value;
      for (UserQuestionModel userModel in userQuestionModels) {
        if (userModel.answer != null || userModel.answer?.isNotEmpty == true) {
          answeredQuestions[category]!['progress'] =
              answeredQuestions[category]!['progress'] + 1;
        }
      }
    }

    return answeredQuestions;
  }

  void resetState() {
    emit(UserQuestionState.initialState());
  }

  @override
  UserQuestionState? fromJson(Map<String, dynamic> json) {
    return UserQuestionState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserQuestionState state) {
    return state.toJson();
  }
}
