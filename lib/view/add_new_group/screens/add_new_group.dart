import 'dart:developer' show log;

import 'package:drosak_app/controller/addNewGroups/add_new_groups_controller.dart';
import 'package:drosak_app/core/resources/const_value_manger.dart';
import 'package:drosak_app/model/appointment/appointment_model.dart';
import 'package:drosak_app/model/education/education_model.dart';
import 'package:drosak_app/view/add_new_group/widgets/appbar/custom_group_app_bar.dart';
import 'package:drosak_app/view/add_new_group/widgets/body/custom_education_time_day_add_new_group.dart';
import 'package:drosak_app/view/add_new_group/widgets/body/custom_group_detailes.dart';
import 'package:drosak_app/view/add_new_group/widgets/body/custom_time_day_ms_add_to_table_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddNewGroup extends StatefulWidget {
  const AddNewGroup({super.key});

  @override
  State<AddNewGroup> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddNewGroup> {
  late AddNewGroupsController controller;

  @override
  void initState() {
    controller = AddNewGroupsController(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.getArg(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.disposeController();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomGroupAppBar(
        title: controller.arguments.toString(),
        addOrUpdate: controller.arguments == "اضافة مجموعة جديدة"
            ? "حفظ الكل"
            : "تعديل",
        onPressed: () {
          controller.onPressedSaveOrEdit();
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity, // مهم لتجنب مشاكل layout
          decoration: BoxDecoration(
            // color: Color(0xff1E1E1E),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomGroupDetailes(
                  formKey: controller.formkey,
                  nameGroup: controller.nameGroup,
                  descGroup: controller.descGroup,
                ),
                Gap(15.h),

                CustomEducationTimeDayAddNewGroup(
                  dayList: ConstValueManger.dayList,
                  educationOnChanged: controller.educationOnChanged,
                  timeOnPressed: () {
                    controller.timeOnPressed(context);
                  },

                  selectDayOnChanged: controller.selectDayOnChanged,
                  selectMSOnChanged: controller.selectMSOnChanged,
                  educationListOutput: controller.listEducationOutput,
                  msRadioOutput: controller.msRadioOutput,
                  timeOutput: controller.timeOutput,
                  outputInitial: controller.initialEducationOutput,
                ),

                Gap(25.h),

                CustomTimeDayMsAddToTableApp(
                  onPressedAddtoAppontTable: () {
                    controller.onPressedAddtoAppontTable(context);
                  },
                  appointemntListOutput: controller.listAppoimentOutput,
                  onTapDelete: (AppointmentModel a1) {
                    controller.onTapDelete(a1);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
