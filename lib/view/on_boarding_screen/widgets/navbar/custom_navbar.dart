import 'package:dots_indicator/dots_indicator.dart';
import 'package:drosak_app/core/resources/const_value_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({
    super.key,
    required this.onNextTap,
    required this.onSkipTap,
    required this.output,
  });
  final GestureTapCallback onNextTap;
  final GestureTapCallback onSkipTap;
  final Stream<int> output;

  @override
  State<CustomNavbar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 39.h,
      color: Color(0xff8012DC),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: widget.onNextTap,

                child: Text(
                  "التالي",
                  style: TextStyle(
                    fontFamily: "AA-GALAXY",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              StreamBuilder<int>(
                stream: widget.output,
                builder: (context, asyncSnapshot) {
                  return DotsIndicator(
                    dotsCount: ConstValueManger.listValue.length,
                    position: asyncSnapshot.data == null
                        ? 0
                        : asyncSnapshot.data!.toDouble(),

                    decorator: DotsDecorator(
                      color: Colors.white, // Inactive color
                      activeColor: Colors.white.withOpacity(0.2),
                      spacing: EdgeInsets.symmetric(horizontal: 3.w),
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: widget.onSkipTap,

                child: Text(
                  "تخطي",
                  style: TextStyle(
                    fontFamily: "AA-GALAXY",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
