import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.text,
    required this.controller,
    this.validator,
  });
  final String text;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      //  textAlign: TextAlign.end,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffFFFFFF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),

        label: Text(
          "$text",
          style: TextStyle(
            fontFamily: "GE-Dinar",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xff47463C),
          ),
        ),
      ),
    );
  }
}
