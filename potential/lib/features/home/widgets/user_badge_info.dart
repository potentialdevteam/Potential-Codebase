import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class UserBadgeInfo extends StatelessWidget {
  const UserBadgeInfo({super.key, required this.userInfo});
  final Map<String, String> userInfo;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: List.generate(userInfo.length, (index) {
        String key = userInfo.keys.elementAt(index);
        String value = userInfo[key] ?? "N/A";
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: height * 0.01),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
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
                    Text(key, style: TextStyle(color: AppColors.accentWhite)),
                  ],
                ),
              ),
              Text(value, style: TextStyle(color: AppColors.accentWhite)),
            ],
          ),
        );
      }),
    );
  }
}
