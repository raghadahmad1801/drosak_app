import 'package:drosak_app/model/appointment/appointment_model.dart';
import 'package:drosak_app/view/education/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomTimeDayMsAddToTableApp extends StatelessWidget {
  const CustomTimeDayMsAddToTableApp({
    super.key,
    required this.onPressedAddtoAppontTable,
    required this.appointemntListOutput,
    required this.onTapDelete,
  });
  final VoidCallback onPressedAddtoAppontTable;
  final Stream<List<AppointmentModel>> appointemntListOutput;
  final Function(AppointmentModel) onTapDelete;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CustomButton(
            text: "اضافة الى جدول المواعيد",
            onPressed: onPressedAddtoAppontTable,
          ),
        ),
        Gap(15.h),

        Center(
          child: StreamBuilder(
            stream: appointemntListOutput,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty) {
                return SizedBox();
              } else {
                return Text(
                  "عدد المواعيد المضافة (${asyncSnapshot.data!.length})",
                  style: TextStyle(color: Colors.white, fontFamily: "GE-Dinar"),
                );
              }
            },
          ),
        ),

        Gap(15.h),
        StreamBuilder<List<AppointmentModel>>(
          stream: appointemntListOutput,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Table(
                border: TableBorder.all(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xff8012DC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "اليوم",
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
                            "الوقت",
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
                            "م/ص",
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
                            "حذف",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "GE-Dinar",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (asyncSnapshot.data != null)
                    for (int i = 0; i < asyncSnapshot.data!.length; i++)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                asyncSnapshot.data![i].day,
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
                                asyncSnapshot.data![i].time,
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
                                asyncSnapshot.data![i].ms,
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
                              child: InkWell(
                                onTap: () =>
                                    onTapDelete(asyncSnapshot.data![i]),
                                child: Icon(
                                  Icons.delete,
                                  color: Color(0xff8012DC),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                ],
              );
            }
          },
        ),

        Gap(10.h),

        StreamBuilder<List<AppointmentModel>>(
          stream: appointemntListOutput,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "لم يتم اضافة اي قيم بعد الى جدول المواعيد",
                  style: TextStyle(color: Colors.white, fontFamily: "GE-Dinar"),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
