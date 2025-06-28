import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';

class UpdatableFieldsData {
  final List<String> profilePicture;
  final FieldWithVisibility<String?> voicePrompt;
  final FieldWithVisibility<List<String>> genderPreference;
  final FieldWithVisibility<String> education;
  final FieldWithVisibility<String> workExperience;
  final FieldWithVisibility<String> socialMediaHandle;
  final String firstMove;
  final bool mysteryModeEnabled;

  UpdatableFieldsData({
    required this.profilePicture,
    required this.voicePrompt,
    required this.genderPreference,
    required this.education,
    required this.workExperience,
    required this.socialMediaHandle,
    required this.firstMove,
    required this.mysteryModeEnabled,
  });

  UpdatableFieldsData copyWith({
    List<String>? profilePicture,
    FieldWithVisibility<String?>? voicePrompt,
    FieldWithVisibility<List<String>>? genderPreference,
    FieldWithVisibility<String>? education,
    FieldWithVisibility<String>? workExperience,
    FieldWithVisibility<String>? socialMediaHandle,
    String? firstMove,
    bool? mysteryModeEnabled,
  }) {
    return UpdatableFieldsData(
      profilePicture: profilePicture ?? this.profilePicture,
      voicePrompt: voicePrompt ?? this.voicePrompt,
      genderPreference: genderPreference ?? this.genderPreference,
      education: education ?? this.education,
      workExperience: workExperience ?? this.workExperience,
      socialMediaHandle: socialMediaHandle ?? this.socialMediaHandle,
      firstMove: firstMove ?? this.firstMove,
      mysteryModeEnabled: mysteryModeEnabled ?? this.mysteryModeEnabled,
    );
  }
}

class UpdatableFieldsCubit extends Cubit<UpdatableFieldsData> {
  UpdatableFieldsCubit()
    : super(
        UpdatableFieldsData(
          profilePicture: [],
          voicePrompt: FieldWithVisibility(value: null, isVisibleToAll: true),
          genderPreference: FieldWithVisibility(
            value: [],
            isVisibleToAll: true,
          ),
          education: FieldWithVisibility(value: "", isVisibleToAll: true),
          workExperience: FieldWithVisibility(value: "", isVisibleToAll: true),
          socialMediaHandle: FieldWithVisibility(
            value: "",
            isVisibleToAll: true,
          ),
          firstMove: "Hey Potential, create a lasting first impression!",
          mysteryModeEnabled: false,
        ),
      );

  // PROFILE PICTURE UPDATION
  void updateSelectedImages(String currentImage, String newImage) {
    final images = List<String>.from(state.profilePicture);
    final index = images.indexOf(currentImage);
    if (index != -1) {
      images[index] = newImage;
    } else {
      images.add(newImage);
    }
    emit(state.copyWith(profilePicture: images));
  }

  void addImage(String image) {
    final updatedImages = List<String>.from(state.profilePicture);
    updatedImages.add(image);
    emit(state.copyWith(profilePicture: updatedImages));
  }

  void removeImage(String imageToRemove) {
    final updatedImages = List<String>.from(state.profilePicture);
    updatedImages.remove(imageToRemove);
    emit(state.copyWith(profilePicture: updatedImages));
  }

  // VOICE PROMPT UPDATION
  void updateVoicePrompt(String? voicePrompt, {bool? isVisibleToAll}) {
    emit(
      state.copyWith(
        voicePrompt: state.voicePrompt.copyWith(
          value: voicePrompt,
          isVisibleToAll: isVisibleToAll,
        ),
      ),
    );
  }

  // GENDER PREFERENCE UPDATION
  void updateGenderPreference(
    List<String> genderPreference, {
    bool? isVisibleToAll,
  }) {
    emit(
      state.copyWith(
        genderPreference: state.genderPreference.copyWith(
          value: genderPreference,
          isVisibleToAll: isVisibleToAll,
        ),
      ),
    );
  }

  // EDUCATION UPDATION
  void updateEducation(String education, {bool? isVisibleToAll}) {
    emit(
      state.copyWith(
        education: state.education.copyWith(
          value: education,
          isVisibleToAll: isVisibleToAll,
        ),
      ),
    );
  }

  // WORK EXPERIENCE UPDATION
  void updateWorkExperience(String workExperience, {bool? isVisibleToAll}) {
    emit(
      state.copyWith(
        workExperience: state.workExperience.copyWith(
          value: workExperience,
          isVisibleToAll: isVisibleToAll,
        ),
      ),
    );
  }

  // SOCIAL MEDIA HANDLE UPDATION
  void updateSocialMediaHandle(
    String socialMediaHandle, {
    bool? isVisibleToAll,
  }) {
    emit(
      state.copyWith(
        socialMediaHandle: state.socialMediaHandle.copyWith(
          value: socialMediaHandle,
          isVisibleToAll: isVisibleToAll,
        ),
      ),
    );
  }

  // MYSTERY MODE UPDATION
  void updateMysteryModeEnabled(bool enabled) {
    emit(state.copyWith(mysteryModeEnabled: enabled));
  }

  // FIRST MOVE UPDATION
  void updateFirstMove(String newFirstMove, {bool? isVisibleToAll}) {
    emit(state.copyWith(firstMove: newFirstMove));
  }

  void updateAllFields(UpdatableFieldsData createAccountData) {
    emit(
      state.copyWith(
        profilePicture: createAccountData.profilePicture,
        voicePrompt: createAccountData.voicePrompt,
        genderPreference: createAccountData.genderPreference,
        education: createAccountData.education,
        workExperience: createAccountData.workExperience,
        socialMediaHandle: createAccountData.socialMediaHandle,
        firstMove: createAccountData.firstMove,
        mysteryModeEnabled: createAccountData.mysteryModeEnabled,
      ),
    );
  }

  void resetAllFields() {
    emit(
      UpdatableFieldsData(
        profilePicture: [],
        voicePrompt: FieldWithVisibility(value: null, isVisibleToAll: true),
        genderPreference: FieldWithVisibility(value: [], isVisibleToAll: true),
        education: FieldWithVisibility(value: "", isVisibleToAll: true),
        workExperience: FieldWithVisibility(value: "", isVisibleToAll: true),
        socialMediaHandle: FieldWithVisibility(value: "", isVisibleToAll: true),
        firstMove: "Hey Potential, create a lasting first impression!",
        mysteryModeEnabled: false,
      ),
    );
  }
}
