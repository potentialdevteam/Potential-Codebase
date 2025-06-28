import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/arena/controllers/bold_admirers_controller.dart';
import 'package:potential/features/arena/cubit/bold_admirers_cubit.dart';
import 'package:potential/features/arena/views/bold_admirer_user_view.dart';

class BoldAdmirers extends StatefulWidget {
  const BoldAdmirers({super.key});

  @override
  State<BoldAdmirers> createState() => _BoldAdmirersState();
}

class _BoldAdmirersState extends State<BoldAdmirers> {
  late final List<BoldAdmirerState> boldAdmirers;

  @override
  void initState() {
    super.initState();
    boldAdmirers = BoldAdmirersController.getBoldAdmirerUsers();
    context.read<BoldAdmirersCubit>().setUsers(boldAdmirers);
  }

  @override
  Widget build(BuildContext context) {
    final profiles = context.read<BoldAdmirersCubit>().state;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bold Admirers",
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
                  child: BlocBuilder<BoldAdmirersCubit, List<BoldAdmirerState>>(
                    bloc: context.read<BoldAdmirersCubit>(),
                    builder: (context, state) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          final BoldAdmirerState profile = state[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRouteTransition(
                                  dest: BoldAdmirerView(user: profile),
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
                                    if (profile.categoryLiked == "Soul")
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
                                          profile.userModel.profilePictures[0],
                                          fit: BoxFit.cover,
                                          width: profile.userModel.soulUnlocked
                                              ? width * 0.38
                                              : width * 0.4,
                                          height: profile.userModel.soulUnlocked
                                              ? width * 0.38
                                              : width * 0.4,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Text(
                                        "${profile.userModel.name}, ${profile.userModel.age}",
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
