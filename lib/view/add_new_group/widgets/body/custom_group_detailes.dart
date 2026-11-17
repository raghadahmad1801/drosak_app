import 'package:drosak_app/view/education/widgets/input_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomGroupDetailes extends StatelessWidget {
  const CustomGroupDetailes({
    super.key,
    required this.formKey,
    required this.nameGroup,
    required this.descGroup,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController nameGroup;
  final TextEditingController descGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تفاصيل المجموعة",
          style: TextStyle(fontFamily: "GE-Dinar", color: Colors.white),
        ),
        Gap(10.h),
        Form(
          key: formKey,
          child: CustomTextFormField(
            controller: nameGroup,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'لا يمكن ترك الحقل فارغا';
              } else {
                return null;
              }
            },
            text: "إسم المجموعة",
          ),
        ),
        Gap(15.h),

        CustomTextFormField(text: "وصف المجموعة", controller: descGroup),
        Gap(5.h),

        Divider(),
      ],
    );
  }
}
