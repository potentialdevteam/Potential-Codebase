import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/core/constants/colors.dart';

class UpdatableField extends StatefulWidget {
  const UpdatableField({
    super.key,
    required this.fieldName,
    required this.fieldValue,
    required this.screenMappings,
  });
  final String fieldName;
  final String fieldValue;
  final Map<String, Widget> screenMappings;
  @override
  State<UpdatableField> createState() => _UpdatableFieldState();
}

class _UpdatableFieldState extends State<UpdatableField> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.15,
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fieldName,
            style: TextStyle(
              color: Colors.grey,
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            splashColor: AppColors.soulYellow,
            child: Container(
              width: width * 0.85,
              height: height * 0.1,
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.symmetric(
                  horizontal: BorderSide(color: AppColors.accentRed, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.fieldValue,
                      style: TextStyle(
                        color: AppColors.accentWhite,
                        fontSize: width * 0.04,
                      ),
                      softWrap: true,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      FadeRouteTransition(
                        dest: widget.screenMappings[widget.fieldName]!,
                      ),
                    ),
                    child: Container(
                      width: width * 0.1,
                      height: width * 0.1,
                      decoration: BoxDecoration(
                        color: AppColors.accentWhite,
                        borderRadius: BorderRadius.circular(width * 0.03),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentRed.withAlpha(200),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.pencil,
                          color: AppColors.accentRed,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
