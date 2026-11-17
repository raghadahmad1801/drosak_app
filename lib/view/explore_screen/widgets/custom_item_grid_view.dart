import 'package:drosak_app/model/explore/explore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomItemGridView extends StatelessWidget {
  const CustomItemGridView({super.key, required this.exploreModel});
  final ExploreModel exploreModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 110,
      decoration: BoxDecoration(
        color: Color(0xff0B0B0F),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        boxShadow: [
          BoxShadow(
            color: Color(0xff8012DC),

            blurRadius: 15.r,
            spreadRadius: 1.r,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 6.w, right: 7.w, top: 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicWidth(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                alignment: Alignment.center,

                height: 30.h,
                decoration: BoxDecoration(
                  color: Color(0xff8012DC),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                child: Text(
                  exploreModel.text,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: "GE-Dinar",
                    color: Color(0xffFFFFFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Gap(10),
            SvgPicture.asset(
              exploreModel.image,
              width: 100.w,
              height: 65.h,
              // fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
