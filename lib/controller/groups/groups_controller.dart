import 'dart:async';

import 'package:drosak_app/core/Database/sqflite/group_operatin.dart';
import 'package:drosak_app/core/resources/route_manager.dart';
import 'package:drosak_app/model/appointment/appointment_model.dart';
import 'package:drosak_app/model/group/group_model.dart';
import 'package:drosak_app/model/group_info/group_info_model.dart';
import 'package:drosak_app/view/education/widgets/search/custom_list_search.dart';
import 'package:drosak_app/view/education/widgets/search/custom_search.dart';
import 'package:drosak_app/view/groups/widgets/search/custom_list_search_group.dart';
import 'package:flutter/material.dart';

class GroupsController {
  late StreamController<List<GroupInfoModel>> listGroupStreamcontroller;
  late Sink<List<GroupInfoModel>> listGroupInfoInput;
  late Stream<List<GroupInfoModel>> listGroupInfoOutput;
  List<GroupInfoModel> listGroupInfo = [];
  String status = "اضافة مجموعة جديدة";
  final BuildContext context;

  void onTap(BuildContext context) async {
    await Navigator.pushNamed(
      context,
      RouteName.kaddNewGroup,
      arguments: status,
    ).then((value) => getAllDataGroupInfo());
  }

  void editFunction(GroupInfoModel) async {
    await Navigator.pushNamed(
      context,
      RouteName.kaddNewGroup,
      arguments: {"status": "تعديل المجموعة", "groupInfoModel": GroupInfoModel},
    ).then((value) => getAllDataGroupInfo());
  }

  GroupsController(this.context) {
    start();
  }

  start() async {
    initController();
    initAllData();
    await getAllDataGroupInfo();
  }

  Future<void> initController() async {
    listGroupStreamcontroller = StreamController();
    listGroupInfoInput = listGroupStreamcontroller.sink;
    listGroupInfoOutput = listGroupStreamcontroller.stream.asBroadcastStream();
  }

  Future<void> disposeController() async {
    listGroupStreamcontroller.close();
    listGroupInfoInput.close();
  }

  initAllData() async {
    listGroupStreamcontroller.add(listGroupInfo);
  }

  getAllDataGroupInfo() async {
    List<GroupModel> groupDeatails = await selectGroupDeatails();
    List<AppointmentModel> appointmentList = await selectAppointmentDetails();
    listGroupInfo.clear();
    for (GroupModel item in groupDeatails) {
      List<AppointmentModel> appList = appointmentList
          .where((e) => e.appGroupId == item.id)
          .toList();

      listGroupInfo.add(
        GroupInfoModel(groupModel: item, appointmentModel: appList),
      );
      initAllData();
    }
  }

  Future<List<GroupModel>> selectGroupDeatails() async {
    GroupOperatin groupOperatin = GroupOperatin();
    return await groupOperatin.selectFromGroup();
  }

  Future<List<AppointmentModel>> selectAppointmentDetails() async {
    GroupOperatin groupOperatin = GroupOperatin();
    return await groupOperatin.selectFromAppointment();
  }

  onRefresh() {
    listGroupInfo.clear();
    listGroupStreamcontroller.add(listGroupInfo);

    Future.delayed(Duration(seconds: 1), () {
      getAllDataGroupInfo();
    });
  }

  void deletefunGroupInfo(GroupInfoModel groupInfoModel) async {
    GroupOperatin groupOperatin = GroupOperatin();
    await groupOperatin.deleteGroupInfo(groupInfoModel);

    onRefresh();
  }

  showSearchDelegate() {
    showSearch(
      context: context,
      delegate: CustomSearch(
        myBuildResult: (query) {
          GroupOperatin groupOperation = GroupOperatin();
          Future<List<GroupInfoModel>> data = groupOperation
              .searchGroupInfoModel(query);
          return CustomListSearchGroup(
            searchList: data,
            deleteFun: deletefunGroupInfo,
            editFun: editFunction,
          );
        },
      ),
    );
  }
}
