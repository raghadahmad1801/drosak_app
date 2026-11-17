import 'dart:async';

import 'package:drosak_app/model/main/main_model.dart';
import 'package:drosak_app/view/auidence/screens/auidence_screen.dart';
import 'package:drosak_app/view/education/screens/education_screen.dart';
import 'package:drosak_app/view/groups/screens/groups_screen.dart';
import 'package:drosak_app/view/payment/screens/payment_screen.dart';
import 'package:drosak_app/view/students/screens/students_screen.dart';
import 'package:flutter/material.dart';

class MainController {
  int currenIndex = 0;
  late StreamController<int> streamControllernav;
  late Sink<int> inputNav;
  late Stream<int> outputNav;
  late StreamController<int> streamControllerBody;
  late Sink<int> inputBody;
  late Stream<int> outputBody;

  MainController() {
    initController();
  }

  initController() {
    streamControllernav = StreamController();
    inputNav = streamControllernav.sink;
    outputNav = streamControllernav.stream;
    inputNav.add(currenIndex);

    streamControllerBody = StreamController();
    inputBody = streamControllerBody.sink;
    outputBody = streamControllerBody.stream;
    inputBody.add(currenIndex);
  }

  disposeController() {
    streamControllernav.close();
    inputNav.close();
    streamControllerBody.close();
    inputBody.close();
  }

  getArguments(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    currenIndex = index;
    inputNav.add(currenIndex);
    inputBody.add(currenIndex);
  }

  List<MainModel> navList = [
    MainModel(
      text: "المراحل\nالتعليمية",
      image: "assets/images/nav_bar_image/class-16-svgrepo-com 1.svg",
      screen: EducationScreen(),
    ),

    MainModel(
      text: "المجموعات",
      image: "assets/images/nav_bar_image/21.svg",
      screen: GroupsScreen(),
    ),
    MainModel(
      text: "الطلاب",
      image:
          "assets/images/nav_bar_image/students-couple-of-a-boy-and-a-girl-svgrepo-com 1.svg",
      screen: StudentsScreen(),
    ),

    MainModel(
      text: "الحضور",
      image: "assets/images/nav_bar_image/mark-all-as-read-svgrepo-com 1.svg",
      screen: AuidenceScreen(),
    ),
    MainModel(
      text: "الدفع",
      image: "assets/images/nav_bar_image/cash-payment-solid-svgrepo-com 1.svg",
      screen: PaymentScreen(),
    ),
  ];

  onTap(value) {
    currenIndex = value;
    inputNav.add(currenIndex);
    inputBody.add(currenIndex);
  }
}
