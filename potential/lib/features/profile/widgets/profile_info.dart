import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class ProfileInfo extends StatelessWidget {
  final String? nameOfVariable;
  final String? valueOfVariable;
  final bool? isVisibleToAll;
  final VoidCallback? onTap;
  const ProfileInfo({
    this.nameOfVariable,
    this.valueOfVariable,
    this.isVisibleToAll,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.soulYellow,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border(
            top: BorderSide(color: AppColors.accentRed, width: 1),
            bottom: BorderSide(color: AppColors.accentRed, width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameOfVariable ?? "Name",
                    style: TextStyle(color: AppColors.accentWhite),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    valueOfVariable ?? "name",
                    style: TextStyle(color: AppColors.accentWhite),
                  ),
                ],
              ),
            ),
            Text(
              isVisibleToAll == true ? "Visible" : "Hidden",
              style: TextStyle(color: AppColors.accentWhite),
            ),
          ],
        ),
      ),
    );
  }
}
