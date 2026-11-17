import 'dart:io';

import 'package:drosak_app/model/education/education_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomItemList extends StatelessWidget {
  const CustomItemList({
    super.key,
    required this.educationModel,
    required this.deleteFun,
    required this.editFun,
  });
  final EducationModel educationModel;
  final Future<bool> Function(EducationModel educationModel) deleteFun;
  final Future Function(EducationModel educationModel) editFun;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(educationModel.id),
      background: Container(
        color: Colors.white,
        child: Text(
          "تعديل",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.white,
        child: Text(
          "حذف",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),

      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          bool? confirm = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("هل تريد حذف هذا العنصر؟"),
                content: Text("هذا الاجراء سيجعلك لا تستطيع "),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("الغاء"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await deleteFun(educationModel);
                      Navigator.of(context).pop(true);
                    },
                    child: Text("حذف", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8012DC),
                    ),
                  ),
                ],
              );
            },
          );

          return confirm;
        } else if (direction == DismissDirection.startToEnd) {
          await editFun(educationModel);
          return false;
        }
        return false;
      },
      child: Stack(
        textDirection: TextDirection.rtl,

        //  alignment: Alignment.topRight,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 30.h, left: 12.w, right: 12.w),
            width: 370.w,
            height: 103.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18.r)),
              color: Color(0xff18171C),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff8012DC),
                  offset: Offset(0, 0),
                  blurRadius: 10.r,
                  // blurStyle: ,
                  spreadRadius: -3.r,
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                educationModel.title,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              educationModel.subTitle,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff514C4C),
                                fontSize: 10.sp,
                              ),
                            ),

                            Gap(20),
                            Text("${educationModel.creatAt}"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              leading: ClipOval(
                child: Image.file(
                  errorBuilder: (context, error, stackTrace) {
                    return SvgPicture.asset(
                      "assets/images/education_images/Vector.svg",
                      width: 80,

                      height: 80,
                      fit: BoxFit.cover,

                      // height: 50,
                    );
                  },

                  width: 80,

                  height: 80,
                  fit: BoxFit.cover,

                  File(educationModel.image),

                  // alignment: Alignment.topLeft,
                ),
              ),
            ),
          ),

          Positioned(
            top: 20.h,
            right: 5.w,
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff18171C),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff8012DC),
                    offset: Offset(0, 0),
                    blurRadius: 10.r,
                    // blurStyle: ,
                    spreadRadius: -3.r,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  educationModel.id.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
