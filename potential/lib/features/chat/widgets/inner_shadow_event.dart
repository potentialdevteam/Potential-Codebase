import 'package:flutter/material.dart';

class InnerShadowContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color shadowColor;

  const InnerShadowContainer({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.shadowColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Your main container
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),

        // Foreground shadow overlay
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.9,
                  colors: [
                    shadowColor.withAlpha(90),
                    Colors.transparent,
                  ],
                  stops: const [1.0, 1.2],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}