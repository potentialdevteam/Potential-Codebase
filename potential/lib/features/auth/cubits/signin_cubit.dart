import 'package:flutter_bloc/flutter_bloc.dart';

enum ProviderType { email, google }
extension ProviderTypeExtension on ProviderType {
  String get name {
    switch (this) {
      case ProviderType.email:
        return 'Email';
      case ProviderType.google:
        return 'Google';
    }
  }
}

class SignInData {
  final String email;
  final String? password;
  final String? uid;
  final ProviderType providerType;

  SignInData({
    required this.email,
    required this.password,
    required this.providerType,
    this.uid,
  });

  @override
  String toString() {
    return 'SignInData(email: $email, password: $password uid: $uid, providerType: ${providerType.name})';
  }

  SignInData copyWith({
    String? email,
    String? password,
    ProviderType? providerType,
    String? uid,
  }) {
    return SignInData(
      email: email ?? this.email,
      password: password ?? this.password,
      providerType: providerType ?? this.providerType,
      uid: uid ?? this.uid,
    );
  }
}

class SigninCubit extends Cubit<SignInData> {
  SigninCubit()
    : super(
        SignInData(
          email: '',
          password: '',
          providerType: ProviderType.email,
          uid: null,
        ),
      );
  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateProviderType(ProviderType providerType) {
    emit(state.copyWith(providerType: providerType));
  }

  void updateUid(String uid) {
    emit(state.copyWith(uid: uid));
  }

  void reset() {
    emit(
      SignInData(
        email: '',
        password: '',
        providerType: ProviderType.email,
        uid: null,
      ),
    );
  }
}
