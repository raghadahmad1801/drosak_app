import 'package:drosak_app/view/add_new_group/screens/add_new_group.dart';
import 'package:drosak_app/view/auidence/screens/auidence_screen.dart';
import 'package:drosak_app/view/education/screens/education_screen.dart';
import 'package:drosak_app/view/explore_screen/screens/explore_screen.dart';
import 'package:drosak_app/view/groups/screens/groups_screen.dart';
import 'package:drosak_app/view/main_screen/screens/main_screen.dart';
import 'package:drosak_app/view/on_boarding_screen/screens/on_boarding_screen.dart';
import 'package:drosak_app/view/payment/screens/payment_screen.dart';
import 'package:drosak_app/view/splach_screen/screens/splach_screen.dart';
import 'package:drosak_app/view/students/screens/students_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Map<String, WidgetBuilder> routes = {
    RouteName.ksplachScreen: (context) => const SplachScreen(),
    RouteName.kOnBoardingScreen: (context) => const OnBoardingScreen(),
    RouteName.kExploreScreen: (context) => const ExploreScreen(),
    RouteName.kMainScreen: (context) => const MainScreen(),
    RouteName.kPaymentScreen: (context) => const PaymentScreen(),
    RouteName.kGroupsScreen: (context) => const GroupsScreen(),
    RouteName.kAudienceScreen: (context) => const AuidenceScreen(),
    RouteName.kEducationScreen: (context) => const EducationScreen(),
    RouteName.kStudentsScreen: (context) => const StudentsScreen(),
    RouteName.kaddNewGroup: (context) => const AddNewGroup(),
  };
}

class RouteName {
  static const ksplachScreen = "SplachScreen";
  static const kOnBoardingScreen = "OnBoardingScreen";
  static const kExploreScreen = "ExploreScreen";
  static const kMainScreen = "MainScreen";
  static const kPaymentScreen = "paymentScreen";
  static const kGroupsScreen = "groupScreen";
  static const kAudienceScreen = "audienceScreen";
  static const kEducationScreen = "educationScreen";
  static const kStudentsScreen = "studentScreen";
  static const kaddNewGroup = "kaddNewGroup";
}
