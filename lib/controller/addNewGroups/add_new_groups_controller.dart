import 'dart:async';

import 'package:drosak_app/core/Database/sqflite/education_stage_data_base.dart';
import 'package:drosak_app/core/Database/sqflite/group_operatin.dart';
import 'package:drosak_app/model/appointment/appointment_model.dart';
import 'package:drosak_app/model/education/education_model.dart';
import 'package:drosak_app/model/group/group_model.dart';
import 'package:drosak_app/model/group_info/group_info_model.dart';
import 'package:flutter/material.dart';

class AddNewGroupsController {
  String arguments = "اضافة مجموعة جديدة";

  late StreamController<List<EducationModel>> listEducationstreamcontroller;
  late Sink<List<EducationModel>> listEducationInput;
  late Stream<List<EducationModel>> listEducationOutput;

  late StreamController<EducationModel> initialStreamcontroller;
  late Sink<EducationModel> initialEducationInput;
  late Stream<EducationModel> initialEducationOutput;

  EducationModel? selectedEducation;

  late StreamController<String> msRadiostreamcontroller;
  late Sink<String> msRadioInput;
  late Stream<String> msRadioOutput;

  late StreamController<String> timeStreamcontroller;
  late Sink<String> timeInput;
  late Stream<String> timeOutput;
  GroupInfoModel? groupInfoModel;

  late StreamController<List<AppointmentModel>> listAppoimentstreamcontroller;
  late Sink<List<AppointmentModel>> listAppoimentInput;
  late Stream<List<AppointmentModel>> listAppoimentOutput;

  GlobalKey<FormState> formkey = GlobalKey();

  TextEditingController nameGroup = TextEditingController();

  TextEditingController descGroup = TextEditingController();

  String groupValue = "م";
  List<EducationModel> educationStageList = [];

  List<AppointmentModel> appointemntGroupList = [];

  TimeOfDay? selectedTime;
  String? selectedDay;
  final BuildContext context;

  AddNewGroupsController(this.context) {
    start();
  }

  void start() async {
    await initController();
    await initAllData();
    msRadioData();
    timeData();
    initAppomentData();
    if (groupInfoModel != null) {
      await fillData();
    }
    initEducation();
  }

  Future<void> initController() async {
    listEducationstreamcontroller = StreamController();
    listEducationInput = listEducationstreamcontroller.sink;
    listEducationOutput = listEducationstreamcontroller.stream;

    msRadiostreamcontroller = StreamController();
    msRadioInput = msRadiostreamcontroller.sink;
    msRadioOutput = msRadiostreamcontroller.stream.asBroadcastStream();

    timeStreamcontroller = StreamController();
    timeInput = timeStreamcontroller.sink;
    timeOutput = timeStreamcontroller.stream;

    listAppoimentstreamcontroller = StreamController();
    listAppoimentInput = listAppoimentstreamcontroller.sink;
    listAppoimentOutput = listAppoimentstreamcontroller.stream
        .asBroadcastStream();

    initialStreamcontroller = StreamController();
    initialEducationInput = initialStreamcontroller.sink;
    initialEducationOutput = initialStreamcontroller.stream;
  }

  Future<void> disposeController() async {
    listEducationstreamcontroller.close();
    listEducationInput.close();
    msRadiostreamcontroller.close();
    msRadioInput.close();
    timeStreamcontroller.close();
    timeInput.close();
    listAppoimentstreamcontroller.close();
    listAppoimentInput.close();
    initialStreamcontroller.close();
    initialEducationInput.close();
  }

  initEducation() {
    if (selectedEducation != null) {
      initialEducationInput.add(selectedEducation!);
    }
  }

  initAllData() async {
    listEducationInput.add(educationStageList);
    await getAllEducation();
  }

  msRadioData() {
    msRadioInput.add(groupValue);
  }

  timeData() {
    if (selectedTime != null) {
      timeInput.add("${selectedTime!.minute} : ${selectedTime!.hour}");
    }
  }

  initAppomentData() {
    listAppoimentInput.add(appointemntGroupList);
  }

  getArg(context) {
    var arg = ModalRoute.of(context);
    if (arg != null) {
      var argument = arg.settings.arguments;
      if (argument is Map) {
        checkEditArgument(argument);
      } else {
        arguments = argument.toString();
      }
    }
  }

  checkEditArgument(Map argument) {
    if (argument.containsKey("status")) {
      arguments = argument["status"];
    }
    if (argument.containsKey("groupInfoModel")) {
      groupInfoModel = argument["groupInfoModel"];
      print(groupInfoModel);
    }
  }

  fillData() {
    nameGroup.text = groupInfoModel!.groupModel.name;
    descGroup.text = groupInfoModel!.groupModel.desc;
    appointemntGroupList += groupInfoModel!.appointmentModel;
    listAppoimentInput.add(appointemntGroupList);
    int stageId = groupInfoModel!.groupModel.educationId;
    print(stageId);

    List<EducationModel> listFound = educationStageList
        .where((e) => e.id == stageId)
        .toList();
    print(educationStageList);
    print(listFound);
    if (listFound.isNotEmpty) {
      selectedEducation = listFound[0];
      initEducation();
      print(selectedEducation);
    }
  }

  void educationOnChanged(EducationModel? e1) {
    if (e1 != null) {
      selectedEducation = e1;
    }
  }

  closeKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void selectDayOnChanged(String? day) {
    if (day != null) selectedDay = day;
    print(selectedDay);
  }

  void selectMSOnChanged(String? valueMs) {
    if (valueMs != null) groupValue = valueMs;
    msRadioInput.add(groupValue);
  }

  void timeOnPressed(context) async {
    closeKeyBoard();
    TimeOfDay? time = await showTimePicker(
      context: context,
      barrierDismissible: false,
      confirmText: "اختر",
      helpText: "اختر الوقت",
      cancelText: "الغاء",

      initialTime: TimeOfDay(hour: 1, minute: 10),
    );
    if (time != null) {
      selectedTime = time;
      timeData();
    }
  }

  void onPressedAddtoAppontTable(context) {
    closeKeyBoard();
    String requiredMsg = "";
    if (selectedDay == null) {
      requiredMsg += "اختر اليوم ";
    }
    if (selectedTime == null) {
      requiredMsg += "واختر الوقت ";
    }
    if (requiredMsg.isEmpty) {
      addtoAppointmentTable();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(requiredMsg)));
    }
  }

  Future<List<EducationModel>> getAllEducation() async {
    EducationStageDataBase educationStageDataBase = EducationStageDataBase();
    educationStageList = await educationStageDataBase.selectFromEducation();
    listEducationInput.add(educationStageList);
    return educationStageList;
  }

  Future<void> addtoAppointmentTable() async {
    appointemntGroupList.add(
      AppointmentModel(
        time: "${selectedTime!.minute} : ${selectedTime!.hour}",
        day: selectedDay!,
        ms: groupValue,
        appGroupId: 0,
      ),
    );
    initAppomentData();
    print("appointemntGroupList + ${appointemntGroupList}");
    print(
      "groupInfoModel!.appointmentModel + ${groupInfoModel!.appointmentModel}",
    );
  }

  onTapDelete(AppointmentModel a1) {
    appointemntGroupList.remove(a1);
    initAppomentData();
    print("appointemntGroupList + ${appointemntGroupList}");
    print(
      "groupInfoModel!.appointmentModel + ${groupInfoModel!.appointmentModel}",
    );
  }

  onPressedSaveAll(BuildContext context) async {
    String requiredData = validateData();
    if (requiredData.isEmpty) {
      int groupId = await insertGroupDetails();
      print(groupId);

      bool insertedApp = true;

      if (groupId > 0) {
        for (var item in appointemntGroupList) {
          item.appGroupId = groupId;
          bool result = await insertAppointmentDetals(item, groupId);

          if (!result) {
            insertedApp = false;
            break;
          }
        }
        if (insertedApp) {
          print("done");
          Navigator.pop(context);
          // print(groupId);
          // print(appointemntGroupList);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("تمت اضافة تفاصيل المجموعة بنجاح")),
          );
        }
      }

      //addd
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(requiredData)));
    }
  }

  onPressedSaveOrEdit() async {
    if (arguments == "اضافة مجموعة جديدة") {
      onPressedSaveAll(context);
    } else {
      print("edit");
      bool updated = await editIntoGroupInfo();
      print(updated);

      if (updated == true) {
        print("done");
        Navigator.pop(context);
        // print(groupId);
        print("appointemntGroupList + ${appointemntGroupList}");
        print(
          "groupInfoModel!.appointmentModel + ${groupInfoModel!.appointmentModel}",
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تمت اضافة تفاصيل المجموعة بنجاح")),
        );
      }
    }
  }

  Future<bool> editIntoGroupInfo() async {
    String requiredData = validateData();
    if (requiredData.isEmpty) {
      //now add to database
      GroupOperatin groupOperatin = GroupOperatin();

      bool edit = await groupOperatin.editGroupInfoModel(
        GroupInfoModel(
          groupModel: GroupModel(
            id: groupInfoModel!.groupModel.id,
            name: nameGroup.text,
            desc: descGroup.text,
            educationId: selectedEducation!.id!,
          ),
          appointmentModel: appointemntGroupList,
        ),
        groupInfoModel!.appointmentModel,
      );
      print(edit);
      return edit;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(requiredData)));
      return false;
    }
  }

  String validateData() {
    String requiredData = "";
    if (nameGroup.text.trim().isEmpty) {
      requiredData += "اضف اسم المجموعة";
    }
    if (selectedEducation == null) {
      requiredData += "واضف المرحلة التعليمة";
    }
    if (appointemntGroupList.isEmpty) {
      requiredData += "واضف موعد واحد ع الاقل للمجموعة";
    }
    return requiredData;
  }

  Future<int> insertGroupDetails() {
    GroupOperatin groupOperatin = GroupOperatin();
    return groupOperatin.insertToGroup(
      GroupModel(
        name: nameGroup.text,
        desc: descGroup.text,
        educationId: selectedEducation!.id!,
      ),
    );
  }

  Future<bool> insertAppointmentDetals(
    AppointmentModel appointment,
    int groupId,
  ) {
    GroupOperatin groupOperatin = GroupOperatin();

    return groupOperatin.insertToAppointment(appointment, groupId);
  }

  // Future<bool> editGroup() async {
  //   String requiredData = validateData();
  //   if (requiredData.isEmpty) {
  //     bool edit = await editGroupInfo();

  //     if (edit) {
  //       print("done");
  //       Navigator.pop(context);
  //       // print(appointemntGroupList);
  //       print(groupInfoModel!.appointmentModel);
  //       // print(groupId);
  //       // print(appointemntGroupList);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("تمت اضافة تفاصيل المجموعة بنجاح")),
  //       );
  //       return true;
  //     }
  //   } else {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(requiredData)));
  //     return false;
  //   }
  //   return false;
  // }

  // Future<bool> editGroupInfo() {
  //   GroupOperatin groupOperatin = GroupOperatin();
  //   return groupOperatin.editGroupInfoModel(
  //     GroupInfoModel(
  //       groupModel: GroupModel(
  //         id: groupInfoModel!.groupModel.id,
  //         name: nameGroup.text,
  //         desc: descGroup.text,
  //         educationId: selectedEducation!.id!,
  //       ),
  //       appointmentModel: appointemntGroupList,
  //     ),
  //     appointemntGroupList,
  //   );
  // }
}
