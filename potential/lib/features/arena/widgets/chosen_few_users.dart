import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/arena/cubit/chosen_few_cubit.dart';
import 'package:potential/features/arena/views/chosen_few_user_view.dart';
import 'package:potential/features/home/models/user_model.dart';

class ChosenFewUsers extends StatelessWidget {
  const ChosenFewUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<ChosenFewCubit, List<UserModel>>(
        bloc: context.read<ChosenFewCubit>(),
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chosen Few",
                style: TextStyle(
                  fontSize: width * 0.06,
                  color: AppColors.accentWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              context.read<ChosenFewCubit>().state.isEmpty
                  ? Text(
                      "Nothing to see here.",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: AppColors.accentWhite,
                      ),
                    )
                  : SizedBox(
                      height: width * 0.5,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: context.read<ChosenFewCubit>().state.length,
                        itemBuilder: (context, index) {
                          final UserModel profile = context
                              .read<ChosenFewCubit>()
                              .state[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRouteTransition(
                                  dest: ChosenFewUserView(
                                    user: context
                                        .read<ChosenFewCubit>()
                                        .state[index],
                                  ),
                                ),
                              );
                            },
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.all(width * 0.015),
                                width: width * 0.4,
                                height: width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.transparent,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(17),
                                        child: Image.network(
                                          profile.profilePictures[0],
                                          fit: BoxFit.cover,
                                          width: width * 0.38,
                                          height: width * 0.38,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Text(
                                        "${profile.name}, ${profile.age}",
                                        style: TextStyle(
                                          color: AppColors.accentWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
