import 'package:flutter/material.dart';

class OnboardingTextfield extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final bool? enabled;

  const OnboardingTextfield({
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.enabled = true,
    super.key,
  });

  @override
  State<OnboardingTextfield> createState() => _OnboardingTextfieldState();
}

class _OnboardingTextfieldState extends State<OnboardingTextfield> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.80,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: screenWidth * 0.8,
            child: Text(
              widget.labelText,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: screenWidth * 0.8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: TextField(
              // disable touch
              enabled: true,
              controller: widget.controller,
              onChanged: widget.onChanged,
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(fontSize: 14),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: widget.suffixIcon ?? SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
