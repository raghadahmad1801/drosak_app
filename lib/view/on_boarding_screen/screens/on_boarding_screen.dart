import 'package:drosak_app/controller/on_boarding/on_boarding_controller.dart';
import 'package:drosak_app/core/resources/const_value_manger.dart';
import 'package:drosak_app/view/on_boarding_screen/widgets/body/custom_item.dart';
import 'package:drosak_app/view/on_boarding_screen/widgets/navbar/custom_navbar.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OnBoardingScreen> {
  late OnBoardingController onBoardingController;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    onBoardingController = OnBoardingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    onBoardingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavbar(
        onNextTap: onBoardingController.onNext,

        onSkipTap: () {
          onBoardingController.onSkip(context);
        },

        output: onBoardingController.output,
      ),

      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: PageView.builder(
          controller: onBoardingController.pageControllerOnBoardingScreen,
          itemCount: ConstValueManger.listValue.length,
          itemBuilder: (context, index) {
            return CustomItem(
              onBoardingModel: ConstValueManger.listValue[index],
            );
          },
        ),
      ),
    );
  }
}
