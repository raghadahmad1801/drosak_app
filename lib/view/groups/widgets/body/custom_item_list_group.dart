import 'dart:io';

import 'package:drosak_app/controller/groups/groups_controller.dart';
import 'package:drosak_app/core/Database/sqflite/group_operatin.dart';
import 'package:drosak_app/model/group_info/group_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomItemListGroup extends StatelessWidget {
  const CustomItemListGroup({
    super.key,
    required this.groupInfo,
    required this.deleteFun,
    required this.editFun,
  });

  final GroupInfoModel groupInfo;
  final Function(GroupInfoModel) deleteFun;
  final Function(GroupInfoModel) editFun;

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.rtl,

      alignment: Alignment.topRight,
      children: [
        Container(
          // padding: EdgeInsets.all(10),
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 30.h, left: 12.w, right: 12.w),
          width: double.infinity,

          // height: 280.h,
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
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      groupInfo.groupModel.name,
                      textAlign: TextAlign.right,

                      // maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "GE-Dinar",
                      ),
                    ),
                    PopupMenuButton(
                      iconColor: Colors.white,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text(
                              "حذف",
                              textAlign: TextAlign.right,

                              // maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "GE-Dinar",
                              ),
                            ),
                            onTap: () async {
                              bool? deleted = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("هل تريد حذف هذا العنصر؟"),
                                    content: Text(
                                      "ان حذفك لهذا العنصر لن يمكنك من استعادته",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text("حذف"),
                                      ),

                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text("لا"),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (deleted == true) {
                                deleteFun(groupInfo);
                              }
                            },
                          ),

                          PopupMenuItem(
                            child: Text(
                              "تعديل",
                              textAlign: TextAlign.right,

                              // maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "GE-Dinar",
                              ),
                            ),
                            onTap: () {
                              editFun(groupInfo);
                            },
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Table(
                  textDirection: TextDirection.rtl,
                  border: TableBorder.all(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      topRight: Radius.circular(14.r),
                    ),
                  ),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Color(0xff8012DC),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14.r),
                          topRight: Radius.circular(14.r),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "اليوم",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "الوقت",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "م/ص",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),

                    for (int i = 0; i < groupInfo.appointmentModel.length; i++)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                groupInfo.appointmentModel[i].day,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "GE-Dinar",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                groupInfo.appointmentModel[i].time,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "GE-Dinar",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                groupInfo.appointmentModel[i].ms,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "GE-Dinar",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              //  Directionality(
              //   textDirection: TextDirection.rtl,
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Column(
              //             // mainAxisAlignment: MainAxisAlignment.start,
              //             // crossAxisAlignment: CrossAxisAlignment.end,
              //             children: [
              //               Text(
              //                 "",
              //                 textAlign: TextAlign.right,
              //                 style: TextStyle(
              //                   color: Color(0xff514C4C),
              //                   fontSize: 10.sp,
              //                 ),
              //               ),

              //               Gap(20),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
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
                groupInfo.groupModel.id.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
