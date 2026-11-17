import 'package:drosak_app/core/Database/sqflite/sqflite_data_base.dart';

class AppointmentModel {
  final String time;
  final String day;
  final String ms;
  int appGroupId;
  final int appId;

  AppointmentModel({
    required this.time,
    required this.day,
    required this.ms,
    required this.appGroupId,
    this.appId = 0,
  });

  @override
  String toString() {
    return "AppointmentModel(appId: $appId, time: $time, day: $day, ms: $ms, groupId: $appGroupId )";
  }

  Map<String, dynamic> toJson(groupId) {
    return {
      SqfliteDataBase.appointmentTime: time,
      SqfliteDataBase.appointmentMS: ms,
      SqfliteDataBase.appointmentDay: day,
      SqfliteDataBase.appointmentGroupsId: groupId,
    };
  }

  factory AppointmentModel.fromJson(Map json) {
    return AppointmentModel(
      time: json[SqfliteDataBase.appointmentTime].toString(),
      ms: json[SqfliteDataBase.appointmentMS].toString(),
      appGroupId:
          int.tryParse(json[SqfliteDataBase.appointmentGroupsId].toString()) ??
          0,

      appId: int.parse(json[SqfliteDataBase.appointmentId].toString()),
      day: json[SqfliteDataBase.appointmentDay].toString(),
    );
  }
}
