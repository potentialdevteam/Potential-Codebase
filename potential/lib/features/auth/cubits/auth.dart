import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthData extends Equatable {
  final String? email;
  final String? uid;
  final bool isLoggedIn;

  const AuthData({this.email, this.uid, this.isLoggedIn = false});

  AuthData copyWith({String? email, String? uid, bool? isLoggedIn}) {
    return AuthData(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  String toString() {
    return 'AuthData(email: $email, uid: $uid, isLoggedIn: $isLoggedIn)';
  }

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      email: json['email'] as String?,
      uid: json['uid'] as String?,
      isLoggedIn: json['isLoggedIn'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'uid': uid, 'isLoggedIn': isLoggedIn};
  }

  @override
  List<Object?> get props => [email, uid, isLoggedIn];
}

class AuthCubit extends HydratedCubit<AuthData> {
  AuthCubit() : super(AuthData(email: null, uid: null, isLoggedIn: false));

  void updateAuthData({String? email, String? uid, bool? isLoggedIn}) {
    emit(state.copyWith(email: email, uid: uid, isLoggedIn: isLoggedIn));
  }

  void resetAuthData() {
    emit(AuthData(email: null, uid: null, isLoggedIn: false));
  }

  @override
  AuthData fromJson(Map<String, dynamic> json) => AuthData.fromJson(json);

  @override
  Map<String, dynamic> toJson(AuthData state) => state.toJson();
}
