import 'dart:developer' show log;
import 'dart:math';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:drosak_app/core/resources/const_value_manger.dart';
import 'package:drosak_app/model/education/education_model.dart';
import 'package:drosak_app/view/education/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class CustomEducationTimeDayAddNewGroup extends StatelessWidget {
  const CustomEducationTimeDayAddNewGroup({
    super.key,

    required this.dayList,
    required this.educationOnChanged,
    required this.timeOnPressed,
    required this.selectDayOnChanged,
    required this.selectMSOnChanged,
    required this.educationListOutput,

    required this.msRadioOutput,
    required this.timeOutput,
    required this.outputInitial,
  });

  final List<String> dayList;
  final Function(EducationModel?) educationOnChanged;
  final VoidCallback timeOnPressed;
  final Stream<String> msRadioOutput;

  final Function(String?) selectDayOnChanged;
  final Function(String?) selectMSOnChanged;
  final Stream<List<EducationModel>> educationListOutput;
  final Stream<String> timeOutput;
  final Stream<EducationModel> outputInitial;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "اختر المرحلة التعليمية",
          style: TextStyle(fontFamily: "GE-Dinar", color: Colors.white),
        ),

        Gap(15.h),

        StreamBuilder2<List<EducationModel>, EducationModel>(
          streams: StreamTuple2(educationListOutput, outputInitial),
          builder: (context, snapshots) {
            if (snapshots.snapshot1.connectionState ==
                ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return CustomDropdown<EducationModel>.search(
                noResultFoundText: "لا يوجد مرحلة تعليمية بهذا الاسم",
                hintText: 'اختر المرحلة التعليمية',
                items: snapshots.snapshot1.data,
                initialItem: snapshots.snapshot2.data,
                onChanged: educationOnChanged,

                listItemBuilder: (context, item, isSelected, onItemSelect) =>
                    ListTile(
                      title: Text(
                        item.title,
                        style: TextStyle(
                          fontFamily: "GE-Dinar",
                          fontSize: 15.sp,
                          // color: Colors.white,
                        ),
                      ),
                      subtitle: item.subTitle.isEmpty
                          ? null
                          : Text(
                              item.subTitle,
                              style: TextStyle(
                                fontFamily: "GE-Dinar",
                                fontSize: 13.sp,
                                // color: Colors.white,
                              ),
                            ),
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xff8012DC),
                        child: Text(
                          item.id.toString(),
                          style: TextStyle(
                            fontFamily: "GE-Dinar",
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                itemsListPadding: EdgeInsets.zero,
                headerBuilder: (context, selectedItem, enabled) => ListTile(
                  title: Text(
                    selectedItem.title,
                    style: TextStyle(
                      fontFamily: "GE-Dinar",
                      fontSize: 15.sp,
                      //  color: Colors.white,
                    ),
                  ),
                  subtitle: selectedItem.subTitle.isEmpty
                      ? null
                      : Text(
                          selectedItem.subTitle,
                          style: TextStyle(
                            fontFamily: "GE-Dinar",
                            fontSize: 12.sp,
                            //  color: Colors.white,
                          ),
                        ),
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xff8012DC),
                    child: Text(
                      selectedItem.id.toString(),
                      style: TextStyle(
                        fontFamily: "GE-Dinar",
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
        Gap(15.h),

        Row(
          children: [
            Text(
              "اليوم",
              style: TextStyle(fontFamily: "GE-Dinar", color: Colors.white),
            ),

            Gap(10.w),

            Expanded(
              child: CustomDropdown<String>.search(
                noResultFoundText: "لا يوجد هذا الاسم",
                hintText: 'اختر اليوم',
                items: dayList,

                onChanged: selectDayOnChanged,
              ),
            ),
          ],
        ),

        Gap(15.h),

        Row(
          children: [
            Text(
              "الوقت",
              style: TextStyle(fontFamily: "GE-Dinar", color: Colors.white),
            ),

            Gap(10.w),

            CustomButton(text: "اختر الوقت", onPressed: timeOnPressed),

            Expanded(
              child: StreamBuilder<String>(
                stream: msRadioOutput,
                builder: (context, asyncSnapshot) {
                  return asyncSnapshot.connectionState ==
                          ConnectionState.waiting
                      ? CircularProgressIndicator()
                      : RadioListTile(
                          title: Text(
                            "م",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "GE-Dinar",
                            ),
                          ),
                          value: "م",

                          groupValue: asyncSnapshot.data,
                          onChanged: selectMSOnChanged,
                        );
                },
              ),
            ),

            Expanded(
              child: StreamBuilder<String>(
                stream: msRadioOutput,
                builder: (context, asyncSnapshot) {
                  return RadioListTile(
                    title: Text(
                      "ص",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "GE-Dinar",
                      ),
                    ),
                    value: "ص",
                    groupValue: asyncSnapshot.data,
                    onChanged: selectMSOnChanged,
                  );
                },
              ),
            ),
          ],
        ),

        Gap(10.h),

        StreamBuilder<String>(
          stream: timeOutput,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            } else if (asyncSnapshot.data == null ||
                asyncSnapshot.data!.isEmpty) {
              return SizedBox();
            } else {
              return Center(
                child: Text(
                  asyncSnapshot.data!,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "GE-Dinar",
                    fontSize: 20,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
