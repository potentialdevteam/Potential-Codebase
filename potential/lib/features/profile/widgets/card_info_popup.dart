import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potential/core/constants/colors.dart';

class CardInfoPopup extends StatelessWidget {
  const CardInfoPopup({
    super.key,
    required this.assetPath,
    required this.texts,
    required this.notes,
    required this.noteTextColor,
  });
  final String assetPath;
  final List<String> texts;
  final List<String> notes;
  final Color noteTextColor;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.8,
      height: height * 0.65,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                assetPath,
                width: width * 0.2,
                height: width * 0.2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(texts.length, (index) {
                  final text = texts[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: AppColors.accentWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
              ),
              SizedBox(height: height * 0.01),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: height * 0.02,
                children: <Widget>[
                  Text(
                    "PLEASE NOTE:",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: noteTextColor,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: height * 0.02,
                    children: List.generate(notes.length, (index) {
                      final note = notes[index];
                      return Text(
                        note,
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color: AppColors.accentWhite,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
