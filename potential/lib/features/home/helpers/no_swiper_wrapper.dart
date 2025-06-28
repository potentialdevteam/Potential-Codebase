import 'package:flutter/material.dart';

class NoSwipeWrapper extends StatelessWidget {
  final Widget child;

  const NoSwipeWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Swallow horizontal swipes
      onHorizontalDragUpdate: (_) {}, 
      onHorizontalDragStart: (_) {},
      onHorizontalDragEnd: (_) {},
      child: child,
    );
  }
}
