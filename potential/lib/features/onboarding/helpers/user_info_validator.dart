import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';

class UserInfoValidator {
  static bool isEmailValid(BuildContext context) {
    if (context.read<CreateAccountCubit>().state.email.isEmpty ||
        !context.read<CreateAccountCubit>().state.email.contains('@') ||
        !context.read<CreateAccountCubit>().state.email.contains('.')) {
      return false;
    }
    return true;
  }

  static bool isPasswordsMatch(String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return false;
    }
    if (password != confirmPassword) {
      return false;
    }
    return true;
  }

  static String isPasswordValid(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty";
    }
    // Check if password is at least 8 characters long
    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }
    // Check if password contains at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Password must contain at least one uppercase letter";
    }
    // Check if password contains at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Password must contain at least one lowercase letter";
    }
    // Check if password contains at least one digit
    if (!RegExp(r'\d').hasMatch(password)) {
      return "Password must contain at least one digit";
    }
    // Check if password contains at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return "Password must contain at least one special character";
    }
    return "Password is valid";
  }

  static bool isNameValid(BuildContext context) {
    if (context.read<CreateAccountCubit>().state.name.value.isEmpty) {
      return false;
    }
    // Check if name contains only letters and spaces
    if (!RegExp(
      r'^[a-zA-Z\s]+$',
    ).hasMatch(context.read<CreateAccountCubit>().state.name.value)) {
      return false;
    }
    // Check if name is at least 2 characters long
    if (context.read<CreateAccountCubit>().state.name.value.length < 2) {
      return false;
    }
    return true;
  }

  static bool isDateOfBirthValid(BuildContext context) {
    if (context.read<CreateAccountCubit>().state.dateOfBirth.value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool isGenderValid(BuildContext context) {
    if (context.read<CreateAccountCubit>().state.gender.value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool isGenderPreferenceValid(BuildContext context) {
    if (context
        .read<CreateAccountCubit>()
        .state
        .genderPreference
        .value
        .isEmpty) {
      return false;
    }
    return true;
  }

  static bool isLocationValid(BuildContext context) {
    if (context.read<CreateAccountCubit>().state.location.value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool isSocialHandleValid(BuildContext context) {
    if (context
        .read<CreateAccountCubit>()
        .state
        .socialMediaHandle
        .value
        .isEmpty) {
      return false;
    }
    return true;
  }
}
