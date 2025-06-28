import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/home/models/user_model.dart';

class ChosenFewCubit extends Cubit<List<UserModel>> {
  ChosenFewCubit() : super(List.from(List<UserModel>.empty()));

  void addUser(UserModel user) {
    emit([...state, user]);
  }

  void removeUser(UserModel user) {
    emit(state.where((UserModel element) => element.email != user.email).toList());
  }
}
