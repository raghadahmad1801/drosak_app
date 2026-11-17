import 'dart:io';
import 'package:drosak_app/view/education/widgets/button/custom_button.dart';
import 'package:drosak_app/view/education/widgets/input_field/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.educationStageNameController,
    required this.educationStageDescController,
    required this.onPressed,
    required this.pickonPressed,
    this.imagePath,
    required this.removeOnPressed,
    required this.outPut,
    required this.formKey,
    this.edit = false,
  });

  final TextEditingController educationStageNameController;
  final TextEditingController educationStageDescController;
  final VoidCallback onPressed;
  final VoidCallback pickonPressed;
  final String? imagePath;
  final VoidCallback removeOnPressed;
  final Stream<String?> outPut;
  final GlobalKey<FormState> formKey;
  final bool edit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity, // مهم لتجنب مشاكل layout
          decoration: BoxDecoration(
            color: Color(0xff1E1E1E),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: formKey,
                        child: CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لا يمكن ترك الحقل فارغا';
                            } else {
                              return null;
                            }
                          },
                          text: "إسم المرحلة التعليمية",
                          controller: educationStageNameController,
                        ),
                      ),
                    ),
                    Gap(5.w),
                    IconButton.filled(
                      onPressed: pickonPressed,
                      icon: SvgPicture.asset(
                        "assets/images/education_images/Vector.svg",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff8012DC),
                      ),
                    ),
                  ],
                ),
                Gap(15.h),

                CustomTextFormField(
                  text: "وصف المرحلة التعليمية",
                  controller: educationStageDescController,
                ),
                Gap(15.h),

                StreamBuilder<String?>(
                  stream: outPut,
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
                      return SizedBox(
                        height: 180.h,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.file(
                              File(asyncSnapshot.data!),
                              width: 180.w,
                              height: 180.h,
                              errorBuilder: (context, error, stackTrace) {
                                return Text("الصورة غير موجودة");
                              },
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: -8.h,
                              right: -13.w,
                              child: IconButton.filled(
                                onPressed: removeOnPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  minimumSize: Size(10, 10),
                                ),
                                iconSize: 15.sp,
                                icon: Icon(CupertinoIcons.trash),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
                Gap(15.h),

                CustomButton(
                  text: edit == true ? "تعديل" : "اضافة",
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
