import 'package:flutter/widgets.dart';

class FadeRouteTransition extends PageRouteBuilder {
  final Widget dest;
  FadeRouteTransition({required this.dest})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) {
          return dest;
        },
        transitionsBuilder:
            (
              context,
              animation, // tells us about the transition progress from the previous page to the new page
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
      );
}
