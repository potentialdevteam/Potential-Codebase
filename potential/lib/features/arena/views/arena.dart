import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/arena/widgets/bold_admirers.dart';
import 'package:potential/features/arena/widgets/chosen_few_users.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ArenaPage extends StatelessWidget {
  const ArenaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final ArenaDataClass arenaData = ArenaDataClass();
    // final ChosenFewService chosenFewService = ChosenFewService();
    // final List<UserModel> chosenFew = chosenFewService.getChosenFewUsers();
    // final List<ArenaProfile> boldAdmirers = arenaData.getBoldAdmirers();

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        title: GradientText(
          'The Arena of Connections!',
          style: TextStyle(
            fontSize: width * 0.065,
            fontWeight: FontWeight.w900,
          ),
          colors: [AppColors.accentWhite, AppColors.accentRed],
        ),
        backgroundColor: AppColors.bgBlack,
        foregroundColor: AppColors.accentWhite,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            spacing: MediaQuery.of(context).size.height * 0.02,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Potential Matches for you...",
                style: TextStyle(
                  fontSize: width * 0.05,
                  color: AppColors.accentWhite,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'Pick Wisely :)',
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: AppColors.accentWhite,
                ),
              ),
              BoldAdmirers(),
              ChosenFewUsers(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
