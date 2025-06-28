import 'dart:io';

class UserModel {
  final String email;
  final String name;
  final int age;
  final String gender; //bo
  final String location;
  final String education;
  final String workExperience;
  final String socialMediaHandle;
  final bool mysteryMode;
  final List<String> profilePictures;
  final File? voicePrompt;
  final Map<String, Map<String, String>> questionAnswers;
  bool soulUnlocked;

  UserModel({
    required this.email,
    required this.name,
    required this.age,
    required this.gender,
    required this.location,
    required this.education,
    required this.workExperience,
    required this.socialMediaHandle,
    required this.mysteryMode,
    required this.profilePictures,
    required this.questionAnswers,
    this.voicePrompt,
    this.soulUnlocked = false,
  });
}
