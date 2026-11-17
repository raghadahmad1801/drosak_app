import 'package:drosak_app/core/resources/route_manager.dart';
import 'package:flutter/material.dart';

class ExploreController {
  void goToMainScreen(BuildContext context, int index) {
    Navigator.pushNamed(context, RouteName.kMainScreen, arguments: index);
  }
}
