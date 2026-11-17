import 'package:drosak_app/core/resources/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.routName});
  final String routName;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: RouteManager.routes,
        initialRoute: routName,
        theme: ThemeData(scaffoldBackgroundColor: Color(0xff18171C)),
      ),
    );
  }
}
