import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum ProviderName { email, google }

extension ProviderTypeExtension on ProviderName {
  String get name {
    switch (this) {
      case ProviderName.email:
        return 'Email';
      case ProviderName.google:
        return 'Google';
    }
  }
}

class FieldWithVisibility<T> extends Equatable {
  final T value;
  final bool? isVisibleToAll;

  const FieldWithVisibility({required this.value, this.isVisibleToAll = true});

  FieldWithVisibility<T> copyWith({T? value, bool? isVisibleToAll}) {
    return FieldWithVisibility<T>(
      value: value ?? this.value,
      isVisibleToAll: isVisibleToAll ?? this.isVisibleToAll,
    );
  }

  @override
  List<Object?> get props => [value, isVisibleToAll];

  Map<String, dynamic> toJson() {
    return {'value': value, 'isVisibleToAll': isVisibleToAll};
  }

  factory FieldWithVisibility.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return FieldWithVisibility(
      value: fromJsonT(json['value']),
      isVisibleToAll: json['isVisibleToAll'],
    );
  }
}

class CreateAccountData extends Equatable {
  // account info
  final String email;
  final String? password;
  final String? confirmPassword;
  final String? uid;
  final String providerName;

  // user info when creating an account
  final FieldWithVisibility<String> name;
  final FieldWithVisibility<String> dateOfBirth;
  final FieldWithVisibility<String> gender;
  final FieldWithVisibility<List<String>> genderPreference;
  final FieldWithVisibility<String> location;
  final FieldWithVisibility<String> education;
  final FieldWithVisibility<String> workExperience;
  final FieldWithVisibility<String> socialMediaHandle;
  final FieldWithVisibility<String?> voicePrompt;
  final List<String> profilePicture;
  final bool mysteryModeEnabled;
  final String? verificationImage;

  // additional fields after login
  final FieldWithVisibility<int> age;
  final String firstMove;

  const CreateAccountData({
    this.email = "",
    this.password = "",
    this.confirmPassword = "",
    this.uid,
    this.providerName = "",

    this.name = const FieldWithVisibility(value: ''),
    this.dateOfBirth = const FieldWithVisibility(value: ''),
    this.gender = const FieldWithVisibility(value: ''),
    this.genderPreference = const FieldWithVisibility(value: []),
    this.location = const FieldWithVisibility(value: ''),
    this.education = const FieldWithVisibility(value: ''),
    this.workExperience = const FieldWithVisibility(value: ''),
    this.socialMediaHandle = const FieldWithVisibility(value: ''),
    this.profilePicture = const [],
    this.mysteryModeEnabled = false,
    this.verificationImage,
    this.voicePrompt = const FieldWithVisibility(value: null),

    this.age = const FieldWithVisibility(value: 0),
    this.firstMove = 'Hey Potential, create a lasting first impression!',
    //
  });

  static CreateAccountData initialState() {
    return CreateAccountData(
      email: "",
      password: "",
      confirmPassword: "",
      uid: "",
      providerName: "Email",
      name: const FieldWithVisibility(value: ''),
      dateOfBirth: const FieldWithVisibility(value: ''),
      gender: const FieldWithVisibility(value: ''),
      genderPreference: const FieldWithVisibility(value: []),
      location: const FieldWithVisibility(value: ''),
      education: const FieldWithVisibility(value: ''),
      workExperience: const FieldWithVisibility(value: ''),
      socialMediaHandle: const FieldWithVisibility(value: ''),
      profilePicture: const [],
      mysteryModeEnabled: false,
      verificationImage: null,
      voicePrompt: const FieldWithVisibility(value: null),
      age: const FieldWithVisibility(value: 0),
      firstMove: 'Hey Potential, create a lasting first impression!',

      /*
        WILL LOOK LIKE THIS IN THE PAYLOAD : 

        firstMove: {
          value: 'Hey Potential, create a lasting first impression!',
          isVisibleToAll: true
        }
      
      */
    );
  }

  CreateAccountData copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? uid,
    String? providerName,

    FieldWithVisibility<String>? name,
    FieldWithVisibility<String>? dateOfBirth,
    FieldWithVisibility<String>? gender,
    FieldWithVisibility<List<String>>? genderPreference,
    FieldWithVisibility<String>? location,
    FieldWithVisibility<String>? education,
    FieldWithVisibility<String>? workExperience,
    FieldWithVisibility<String>? socialMediaHandle,
    List<String>? profilePicture,
    bool? mysteryModeEnabled,
    String? verificationImage,
    FieldWithVisibility<String?>? voicePrompt,

    FieldWithVisibility<int>? age,
    String? firstMove,
  }) {
    return CreateAccountData(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      uid: uid ?? this.uid,
      providerName: providerName ?? this.providerName,

      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      genderPreference: genderPreference ?? this.genderPreference,
      location: location ?? this.location,
      education: education ?? this.education,
      workExperience: workExperience ?? this.workExperience,
      socialMediaHandle: socialMediaHandle ?? this.socialMediaHandle,
      voicePrompt: voicePrompt ?? this.voicePrompt,
      profilePicture: profilePicture ?? this.profilePicture,
      mysteryModeEnabled: mysteryModeEnabled ?? this.mysteryModeEnabled,
      verificationImage: verificationImage ?? this.verificationImage,

      age: age ?? this.age,
      firstMove: firstMove ?? this.firstMove,
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [
    email,
    password,
    confirmPassword,
    uid,
    providerName,
    name,
    dateOfBirth,
    gender,
    genderPreference,
    location,
    education,
    workExperience,
    socialMediaHandle,
    voicePrompt,
    profilePicture,
    verificationImage,
    mysteryModeEnabled,
    age,
    firstMove,
  ];

  factory CreateAccountData.fromJson(Map<String, dynamic> json) {
    return CreateAccountData(
      email: json['email'] as String,
      password: json['password'] as String? ?? "",
      confirmPassword: json['confirmPassword'] as String? ?? "",
      uid: json['uid'] as String? ?? "",
      providerName: json['providerName'] as String,
      name: FieldWithVisibility.fromJson(
        json['name'] as Map<String, dynamic>,
        (jsonValue) => jsonValue as String,
      ),
      dateOfBirth: FieldWithVisibility.fromJson(
        json['dateOfBirth'] as Map<String, dynamic>,
        (jsonValue) => jsonValue as String,
      ),
      gender: FieldWithVisibility.fromJson(
        json['gender'] as Map<String, dynamic>,
        (jsonValue) => jsonValue as String,
      ),
      genderPreference: FieldWithVisibility.fromJson(
        json['genderPreference'] as Map<String, dynamic>,
        (jsonValue) => jsonValue as List<String>,
      ),
      location: FieldWithVisibility.fromJson(
        json['location'] as Map<String, dynamic>,
        (jsonValue) => jsonValue as String,
      ),
      education: FieldWithVisibility.fromJson(
        json['education'] as Map<String, dynamic>,
        (jsonValue) => jsonValue as String,
      ),
      workExperience: FieldWithVisibility.fromJson(
        json['workExperience'] as Map<String, dynamic>,
        (jsonValue) => jsonValue as String,
      ),
      socialMediaHandle: FieldWithVisibility.fromJson(
        json['socialMediaHandle'] as Map<String, dynamic>,
        (jsonValue) => jsonValue as String,
      ),
      voicePrompt: json['voicePrompt'] != null
          ? FieldWithVisibility<String?>(
              value: json['voicePrompt']['value'] != null
                  ? json['voicePrompt']['value'] as String
                  : null,
              isVisibleToAll: json['voicePrompt']['isVisibleToAll'] as bool,
            )
          : const FieldWithVisibility<String?>(value: null),

      profilePicture:
          (json['profilePicture'] as List<String>?)
              ?.map((path) => path)
              .toList() ??
          [],

      verificationImage: json['verificationImage'] as String?,
      mysteryModeEnabled: json['mysteryModeEnabled'] as bool? ?? false,
      age: FieldWithVisibility.fromJson(
        json['age'] as Map<String, dynamic>,
        (jsonValue) => jsonValue as int,
      ),
      firstMove:
          json['firstMove'] as String? ??
          'Hey Potential, create a lasting first impression!',
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'uid': uid,
      'providerName': providerName,
      'name': {'value': name.value, 'isVisibleToAll': name.isVisibleToAll},
      'dateOfBirth': {
        'value': dateOfBirth.value,
        'isVisibleToAll': dateOfBirth.isVisibleToAll,
      },
      'gender': {
        'value': gender.value,
        'isVisibleToAll': gender.isVisibleToAll,
      },
      'genderPreference': {
        'value': genderPreference.value,
        'isVisibleToAll': genderPreference.isVisibleToAll,
      },
      'location': {
        'value': location.value,
        'isVisibleToAll': location.isVisibleToAll,
      },
      'education': {
        'value': education.value,
        'isVisibleToAll': education.isVisibleToAll,
      },
      'workExperience': {
        'value': workExperience.value,
        'isVisibleToAll': workExperience.isVisibleToAll,
      },
      'socialMediaHandle': {
        'value': socialMediaHandle.value,
        'isVisibleToAll': socialMediaHandle.isVisibleToAll,
      },
      'voicePrompt': {
        'value': voicePrompt.value,
        'isVisibleToAll': voicePrompt.isVisibleToAll,
      },
      'profilePicture': profilePicture,
      'verificationImage': verificationImage,
      'mysteryModeEnabled': mysteryModeEnabled,
      'age': {'value': age.value, 'isVisibleToAll': age.isVisibleToAll},
      'firstMove': firstMove,
    };
  }
}

class CreateAccountCubit extends HydratedCubit<CreateAccountData> {
  CreateAccountCubit() : super(_loadInitialState());

  static CreateAccountData _loadInitialState() {
    return CreateAccountData.initialState();
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void updateUid(String uid) {
    emit(state.copyWith(uid: uid));
  }

  void updateProviderName(String providerName) {
    emit(state.copyWith(providerName: providerName));
  }

  void updateName(String name, {bool? isVisibleToAll}) {
    emit(
      state.copyWith(
        name: state.name.copyWith(value: name, isVisibleToAll: isVisibleToAll),
      ),
    );
  }

  void updateDateOfBirth(String dateOfBirth, {bool? isVisibleToAll}) {
    emit(
      state.copyWith(
        dateOfBirth: state.dateOfBirth.copyWith(
          value: dateOfBirth,
          isVisibleToAll: isVisibleToAll,
        ),
      ),
    );
  }

  void updateGender(String gender, {bool? isVisibleToAll}) {
    emit(
      state.copyWith(
        gender: state.gender.copyWith(
          value: gender,
          isVisibleToAll: isVisibleToAll,
        ),
      ),
    );
  }

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

  void updateLocation(String location, {bool? isVisibleToAll}) {
    emit(
      state.copyWith(
        location: state.location.copyWith(
          value: location,
          isVisibleToAll: isVisibleToAll,
        ),
      ),
    );
  }

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

  void setVerificationImage(String? image) {
    emit(state.copyWith(verificationImage: image));
  }

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

  void updateMysteryModeEnabled(bool enabled) {
    emit(state.copyWith(mysteryModeEnabled: enabled));
  }

  void updateAge(int age, {bool? isVisibleToAll}) {
    emit(
      state.copyWith(
        age: state.age.copyWith(value: age, isVisibleToAll: isVisibleToAll),
      ),
    );
  }

  void updateFirstMove(String newFirstMove, {bool? isVisibleToAll}) {
    emit(state.copyWith(firstMove: newFirstMove));
  }

  void reset() {
    emit(CreateAccountData.initialState());
  }

  @override
  CreateAccountData? fromJson(Map<String, dynamic> json) {
    try {
      return CreateAccountData.fromJson(json);
    } catch (e) {
      log('❌ Failed to restore CreateAccountData: $e');
      return null; // Triggers fallback to initial state
    }
  }

  @override
  Map<String, dynamic>? toJson(CreateAccountData state) {
    final json = state.toJson();
    return json;
  }
}
