import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/arena/cubit/chosen_few_cubit.dart';
import 'package:potential/features/arena/views/chosen_few_user_view.dart';
import 'package:potential/features/home/models/user_model.dart';

class ArenaProfiles extends StatefulWidget {
  final String text;
  const ArenaProfiles({super.key, required this.text});

  @override
  State<ArenaProfiles> createState() => _ArenaProfilesState();
}

class _ArenaProfilesState extends State<ArenaProfiles> {
  @override
  Widget build(BuildContext context) {
    final profiles = context.read<ChosenFewCubit>().state;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(
              fontSize: width * 0.06,
              color: AppColors.accentWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          profiles.isEmpty
              ? Text(
                  "Nothing to see here.",
                  style: TextStyle(
                    fontSize: width * 0.05,
                    color: AppColors.accentWhite,
                  ),
                )
              : SizedBox(
                  height: width * 0.5,
                  child: BlocBuilder<ChosenFewCubit, List<UserModel>>(
                    bloc: context.read<ChosenFewCubit>(),
                    builder: (context, profiles) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: profiles.length,
                        itemBuilder: (context, index) {
                          final UserModel profile = profiles[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRouteTransition(
                                  dest: ChosenFewUserView(
                                    user: profiles[index],
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
                                  color: Colors.red,
                                ),
                                child: Stack(
                                  children: [
                                    if (profile.soulUnlocked)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.accentWhite,
                                              AppColors.soulYellow,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                        ),
                                      ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(17),
                                        child: Image.network(
                                          profile.profilePictures[0],
                                          fit: BoxFit.cover,
                                          width: profile.soulUnlocked
                                              ? width * 0.38
                                              : width * 0.4,
                                          height: profile.soulUnlocked
                                              ? width * 0.38
                                              : width * 0.4,
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
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
