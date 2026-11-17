import 'package:drosak_app/controller/splach_screen/splach_screen_controller.dart';
import 'package:drosak_app/core/resources/route_manager.dart';
import 'package:flutter/material.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplachScreen>
    with SingleTickerProviderStateMixin {
  late SplachScreenController splachScreenController;
  @override
  void initState() {
    // TODO: implement initState
    splachScreenController = SplachScreenController(this, context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    splachScreenController.disposeSplach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SlideTransition(
              position: splachScreenController.animationTop,
              child: Image.asset(
                "assets/splach_screen_image/group2_splach.png",
              ),
            ),
          ),

          Center(
            child: Image.asset("assets/splach_screen_image/splach_logo.png"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SlideTransition(
              position: splachScreenController.animationBottom,
              child: Image.asset(
                "assets/splach_screen_image/group1_splach.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
