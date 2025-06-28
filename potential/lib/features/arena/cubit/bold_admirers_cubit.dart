import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/home/models/user_model.dart';

class BoldAdmirerState {
  final UserModel userModel;
  final String categoryLiked;
  
  // tentative
  final String assetPath;
  String? question;
  String? answer;
  String? appreciation;

  BoldAdmirerState({
    required this.userModel,
    required this.categoryLiked,
    required this.assetPath,
    this.answer,
    this.question,
    this.appreciation,
  });
}

class BoldAdmirersCubit extends Cubit<List<BoldAdmirerState>> {
  BoldAdmirersCubit() : super(List.from([]));

  void addUser(
    UserModel user,
    String categoryLiked,
    String assetPath,
    String? question,
    String? answer,
    String? appreciation,
  ) {
    emit([
      ...state,
      BoldAdmirerState(
        userModel: user,
        categoryLiked: categoryLiked,
        assetPath: assetPath,
        question: question,
        answer: answer,
        appreciation: appreciation,
      ),
    ]);
  }

  void removeUser(BoldAdmirerState user) {
    emit(
      state
          .where(
            (BoldAdmirerState element) =>
                element.userModel.email != user.userModel.email,
          )
          .toList(),
    );
  }

  void setUsers(List<BoldAdmirerState> users) {
    emit(users);
  }
}
