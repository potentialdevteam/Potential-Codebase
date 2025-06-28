// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:potential/features/profile/models/question_categories.dart';

class QuestionProgress extends Equatable {
  final int progress;
  const QuestionProgress(this.progress);

  factory QuestionProgress.fromJson(Map<String, dynamic> json) {
    return QuestionProgress(json['progress'] as int);
  }

  Map<String, int> toJson() {
    return {"progress": progress};
  }

  @override
  List<Object?> get props => [progress];
}

class QuestionProgressState extends Equatable {
  final QuestionProgress sparkProgress;
  final QuestionProgress mindProgress;
  final QuestionProgress heartProgress;
  final QuestionProgress soulProgress;

  const QuestionProgressState({
    required this.sparkProgress,
    required this.mindProgress,
    required this.heartProgress,
    required this.soulProgress,
  });

  QuestionProgressState copyWith({
    QuestionProgress? sparkProgress,
    QuestionProgress? mindProgress,
    QuestionProgress? heartProgress,
    QuestionProgress? soulProgress,
  }) {
    return QuestionProgressState(
      sparkProgress: sparkProgress ?? this.sparkProgress,
      mindProgress: mindProgress ?? this.mindProgress,
      heartProgress: heartProgress ?? this.heartProgress,
      soulProgress: soulProgress ?? this.soulProgress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sparkProgress': sparkProgress.toJson(),
      'mindProgress': mindProgress.toJson(),
      'heartProgress': heartProgress.toJson(),
      'soulProgress': soulProgress.toJson(),
    };
  }

  factory QuestionProgressState.fromJson(Map<String, dynamic> json) {
    return QuestionProgressState(
      sparkProgress: QuestionProgress.fromJson(
        json['sparkProgress'] as Map<String, dynamic>,
      ),
      mindProgress: QuestionProgress.fromJson(
        json['mindProgress'] as Map<String, dynamic>,
      ),
      heartProgress: QuestionProgress.fromJson(
        json['heartProgress'] as Map<String, dynamic>,
      ),
      soulProgress: QuestionProgress.fromJson(
        json['soulProgress'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  String toString() => json.encode(toJson());

  @override
  List<Object?> get props => [
    sparkProgress,
    mindProgress,
    heartProgress,
    soulProgress,
  ];
}

class QuestionProgressCubit extends HydratedCubit<QuestionProgressState> {
  QuestionProgressCubit()
    : super(
        QuestionProgressState(
          sparkProgress: QuestionProgress(0),
          mindProgress: QuestionProgress(0),
          heartProgress: QuestionProgress(0),
          soulProgress: QuestionProgress(0),
        ),
      );

  void updateProgressState(QuestionProgressState state) {
    emit(state);
  }

  void updateProgress(QuestionCategory category, bool isNewAnswer) {
    final currentState = state;
    switch (category) {
      case QuestionCategory.spark:
        if (isNewAnswer) {
          emit(
            currentState.copyWith(
              sparkProgress: QuestionProgress(
                currentState.sparkProgress.progress + 1,
              ),
            ),
          );
          return;
        }
        break;
      case QuestionCategory.mind:
        if (isNewAnswer) {
          emit(
            currentState.copyWith(
              mindProgress: QuestionProgress(
                currentState.mindProgress.progress + 1,
              ),
            ),
          );
          return;
        }
        break;
      case QuestionCategory.heart:
        if (isNewAnswer) {
          emit(
            currentState.copyWith(
              heartProgress: QuestionProgress(
                currentState.heartProgress.progress + 1,
              ),
            ),
          );
          return;
        }
        break;
      case QuestionCategory.soul:
        if (isNewAnswer) {
          emit(
            currentState.copyWith(
              soulProgress: QuestionProgress(
                currentState.soulProgress.progress + 1,
              ),
            ),
          );
          return;
        }
        break;
    }
  }

  @override
  QuestionProgressState? fromJson(Map<String, dynamic> json) {
    return QuestionProgressState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(QuestionProgressState state) {
    return state.toJson();
  }
}
