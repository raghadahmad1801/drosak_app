import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(122.w, 40.h),
        backgroundColor: Color(0xff8012DC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        "$text",
        style: TextStyle(
          fontFamily: "GE-Dinar",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xffFFFFFF),
        ),
      ),
    );
  }
}
