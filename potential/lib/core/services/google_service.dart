import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:potential/features/auth/cubits/auth.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/features/auth/cubits/signin_cubit.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/home/views/layout.dart';
import 'package:potential/features/onboarding/views/profile_creation.dart';

class GoogleAuthClass {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> getUserCredentials() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      throw Exception("Google Sign-In cancelled by user");
    }

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final creds = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential userCredential = await _firebaseAuth.signInWithCredential(
      creds,
    );
    return userCredential;
  }

  signInWithGoogle(BuildContext context) async {
    try {
      UserCredential userCredential = await getUserCredentials();
      if (context.mounted && userCredential.user != null) {
        final email = userCredential.user!.email;
        final uid = userCredential.user!.uid;
        context.read<AuthCubit>().updateAuthData(
          email: email,
          uid: uid,
          isLoggedIn: true,
        );
        context.read<SigninCubit>().updateEmail(email!);
        context.read<SigninCubit>().updateProviderType(ProviderType.google);
        context.read<SigninCubit>().updateUid(uid);
        // Navigate to home page or perform any other action
        Navigator.pushAndRemoveUntil(
          context,
          FadeRouteTransition(dest: HomeLayout()),
          (route) => false,
        );
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User is null after Google Sign-In")),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error during Google Sign-In")));
      }
    }
  }

  signOut(BuildContext context) async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  void createUserWithGoogle(BuildContext context) async {
    try {
      UserCredential userCredential = await getUserCredentials();
      if (context.mounted && userCredential.user != null) {
        final email = userCredential.user!.email;
        final uid = userCredential.user!.uid;
        context.read<CreateAccountCubit>().updateEmail(email!);
        context.read<CreateAccountCubit>().updateProviderName(
          ProviderName.google.name,
        );
        context.read<CreateAccountCubit>().updateUid(uid);
        // Navigate to home page or perform any other action
        Navigator.push(
          context,
          FadeRouteTransition(dest: const ProfileCreationScreen()),
        );
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User is null after Google Sign-In")),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error during Google Sign-In")));
      }
    }
  }
}
