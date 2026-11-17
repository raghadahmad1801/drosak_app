import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:drosak_app/app/my_app.dart';
import 'package:drosak_app/core/resources/route_manager.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String kroutName = await check();
  runApp(MyApp(routName: kroutName));
}

Future<String> check() async {
  String? androidVersion = await getVersion();

  if (androidVersion != null) {
    if (int.parse(androidVersion) >= 12) {}
    return RouteName.ksplachScreen;
  }
  return RouteName.kOnBoardingScreen;
}

Future<String?> getVersion() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.release;
  }
  return null;
}
