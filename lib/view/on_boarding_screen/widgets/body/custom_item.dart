import 'package:drosak_app/model/on_boarding/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomItem extends StatelessWidget {
  const CustomItem({super.key, required this.onBoardingModel});
  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(onBoardingModel.image, height: 190.h),
          Gap(60.h),
          Text(
            textAlign: TextAlign.center,
            onBoardingModel.text,
            style: TextStyle(fontSize: 20.sp, fontFamily: "AA-GALAXY"),
          ),
        ],
      ),
    );
  }
}
