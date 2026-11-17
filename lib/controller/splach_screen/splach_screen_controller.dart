import 'package:drosak_app/core/resources/route_manager.dart';
import 'package:flutter/material.dart';

class SplachScreenController {
  late AnimationController animationController;
  late Animation<Offset> animationTop;
  late Animation<Offset> animationBottom;
  final TickerProvider vsync;
  final BuildContext context;

  SplachScreenController(this.vsync, this.context) {
    initSplach();
  }

  initSplach() {
    startAnimation();
  }

  startAnimation() {
    animationController =
        AnimationController(vsync: vsync, duration: Duration(seconds: 2))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              goToOnboardingPage();
            }
          });

    animationTop = Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: animationController, curve: Curves.linear),
        );
    animationBottom = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: animationController, curve: Curves.linear),
        );

    animationController.forward();
  }

  disposeSplach() {
    animationController.dispose();
  }

  void goToOnboardingPage() {
    Navigator.pushReplacementNamed(context, RouteName.kOnBoardingScreen);
  }
}
