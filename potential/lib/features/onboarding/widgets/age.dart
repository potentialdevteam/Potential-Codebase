import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';

class ProfileAge extends StatefulWidget {
  const ProfileAge({super.key});

  @override
  State<ProfileAge> createState() => _ProfileAgeState();
}

class _ProfileAgeState extends State<ProfileAge> {
  late DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    pickedDate =
        context.read<CreateAccountCubit>().state.dateOfBirth.value.isEmpty
        ? DateTime.now()
        : DateTime.parse(
            context.read<CreateAccountCubit>().state.dateOfBirth.value.split(
              " ",
            )[0],
          );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      width: MediaQuery.of(context).size.width * 0.80,
      child: Column(
        spacing: MediaQuery.of(context).size.height * 0.02,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "How old are you?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),

          GestureDetector(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                firstDate: DateTime(1900, 1, 1),
                lastDate: DateTime.now(),
                currentDate: DateTime.now(),
              );
              if (context.mounted && pickedDate != null) {
                context.read<CreateAccountCubit>().updateDateOfBirth(
                  pickedDate.toString(),
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: screenWidth * 0.80,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: AppColors.accentWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: BlocBuilder<CreateAccountCubit, CreateAccountData>(
                builder: (context, state) => Text(
                  state.dateOfBirth.value.split(" ")[0].isEmpty
                      ? "Select your date of birth"
                      : state.dateOfBirth.value.split(" ")[0],
                  style: TextStyle(color: AppColors.bgBlack, fontSize: 18),
                ),
              ),
            ),
          ),

          Text(
            "This is a required field.",
            style: TextStyle(color: AppColors.accentWhite),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                BlocBuilder<CreateAccountCubit, CreateAccountData>(
                  builder: (context, state) {
                    return Checkbox(
                      value:
                          context
                              .watch<CreateAccountCubit>()
                              .state
                              .dateOfBirth
                              .isVisibleToAll ??
                          false,
                      onChanged: (value) {
                        context.read<CreateAccountCubit>().updateDateOfBirth(
                          state.dateOfBirth.value.split(" ")[0],
                          isVisibleToAll: value ?? false,
                        );
                      },
                      activeColor: AppColors.accentRed,
                    );
                  },
                ),
                Text(
                  "Visible to everyone",
                  style: TextStyle(color: AppColors.accentWhite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
