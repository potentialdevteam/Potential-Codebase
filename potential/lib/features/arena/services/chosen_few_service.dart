import 'package:potential/features/arena/controllers/chosen_few_controller.dart';
import 'package:potential/features/home/models/user_model.dart';

class ChosenFewService {

  ChosenFewController chosenFewController = ChosenFewController();

  List<UserModel> getChosenFewUsers() {
    return chosenFewController.getChosenFewUsers();
  }
}