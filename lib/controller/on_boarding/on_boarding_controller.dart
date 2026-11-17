import 'dart:async';

import 'package:drosak_app/core/resources/const_value_manger.dart';
import 'package:drosak_app/core/resources/route_manager.dart';
import 'package:flutter/material.dart';

class OnBoardingController {
  PageController pageControllerOnBoardingScreen = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;
  late StreamController<int> streamController;
  late Sink<int> input;
  late Stream<int> output;

  OnBoardingController() {
    streamController = StreamController();
    input = streamController.sink;
    output = streamController.stream;
    input.add(currentIndex);
  }

  onNext() {
    if (currentIndex + 1 >= ConstValueManger.listValue.length) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }

    pageControllerOnBoardingScreen.animateToPage(
      currentIndex,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    input.add(currentIndex);
  }

  void onSkip(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteName.kExploreScreen,
      (route) => false,
    );
  }

  dispose() {
    streamController.close();
    input.close();
  }
}
