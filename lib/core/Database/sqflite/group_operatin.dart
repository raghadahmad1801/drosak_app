import 'package:drosak_app/core/Database/sqflite/sqflite_data_base.dart';
import 'package:drosak_app/model/appointment/appointment_model.dart';
import 'package:drosak_app/model/group/group_model.dart';
import 'package:drosak_app/model/group_info/group_info_model.dart';

class GroupOperatin extends SqfliteDataBase {
  Future<int> insertToGroup(GroupModel groupModel) {
    return insertId(SqfliteDataBase.groupsTable, groupModel.toJson());
  }

  Future<bool> insertToAppointment(AppointmentModel appointmentModel, groupId) {
    return insert(
      SqfliteDataBase.appointmentTable,
      appointmentModel.toJson(groupId),
    );
  }

  Future<List<GroupModel>> selectFromGroup() async {
    List<Map<String, Object?>> data = await select(
      table: SqfliteDataBase.groupsTable,
    );

    List<GroupModel> groupList = [];

    for (var item in data) {
      groupList.add(GroupModel.fromJson(item));
    }
    //  listEducation += data.map((e) => EducationModel.fromJson(e)).toList();

    return groupList;
  }

  Future<List<AppointmentModel>> selectFromAppointment() async {
    List<Map<String, Object?>> data = await select(
      table: SqfliteDataBase.appointmentTable,
    );

    List<AppointmentModel> appointmentList = [];

    for (var item in data) {
      appointmentList.add(AppointmentModel.fromJson(item));
    }
    //  listEducation += data.map((e) => EducationModel.fromJson(e)).toList();

    return appointmentList;
  }

  Future<bool> deleteGroupInfo(GroupInfoModel groupInfo) {
    return delete(
      SqfliteDataBase.groupsTable,
      "${SqfliteDataBase.groupsId} =?",
      [groupInfo.groupModel.id],
    );
  }

  Future<bool> deleteAppointment(AppointmentModel appointmentModel) {
    return delete(
      SqfliteDataBase.appointmentTable,
      "${SqfliteDataBase.appointmentId} =?",
      [appointmentModel.appId],
    );
  }

  Future<bool> editGroup(GroupModel groupModel) async {
    return await update(
      SqfliteDataBase.groupsTable,

      groupModel.toJson(),
      "${SqfliteDataBase.groupsId}=?",
      [groupModel.id],
    );
  }

  Future<bool> editAppointment(
    AppointmentModel appointmnetModel,
    int groupId,
  ) async {
    return await update(
      SqfliteDataBase.appointmentTable,

      appointmnetModel.toJson(groupId),
      "${SqfliteDataBase.appointmentId}=?",
      [appointmnetModel.appId],
    );
  }

  Future<bool> editGroupInfoModel(
    GroupInfoModel groupInfoModel,
    List<AppointmentModel> oldAppointmentModel,
  ) async {
    GroupOperatin groupOperatin = GroupOperatin();
    // 1️⃣ تحديث الجروب
    bool updateGroup = await editGroup(groupInfoModel.groupModel);
    if (!updateGroup) return false;

    // 2️⃣ حذف المواعيد القديمة
    for (var item in oldAppointmentModel) {
      // GroupOperatin groupOperatin = GroupOperatin();
      bool deleted = await groupOperatin.deleteAppointment(item);
      if (!deleted) {
        return false; // أول ما يفشل الحذف نرجع false
      }
    }

    // 3️⃣ إدخال المواعيد الجديدة
    for (var item in groupInfoModel.appointmentModel) {
      // GroupOperatin groupOperatin = GroupOperatin();
      bool inserted = await groupOperatin.insertToAppointment(
        item,
        groupInfoModel.groupModel.id,
      );

      if (!inserted) {
        return false; // أول ما يفشل الإدخال نرجع false
      }
    }

    return true; // إذا كل شيء نجح
  }

  Future<List<GroupModel>> getSearch(String searchWord) async {
    List<GroupModel> groupList = [];

    List group = await search(
      searchWord,
      SqfliteDataBase.groupsName,
      SqfliteDataBase.groupsTable,
    );

    for (var item in group) {
      groupList.add(GroupModel.fromJson(item));
    }
    //  listEducation += data.map((e) => EducationModel.fromJson(e)).toList();

    return groupList;
  }

  Future<List<GroupInfoModel>> searchGroupInfoModel(String searchWord) async {
    List<GroupInfoModel> groupInfoModel = [];
    List<GroupModel> searchGroupName = await getSearch(searchWord);
    List<AppointmentModel> appointmentList = [];

    for (var item in searchGroupName) {
      GroupOperatin groupsOperation = GroupOperatin();
      appointmentList += await groupsOperation.getSearchAppointmentList(
        item.id!.toString(),
      );
    }

    for (var item in searchGroupName) {
      List<AppointmentModel> newAppointmentList = appointmentList
          .where((element) => element.appGroupId == item.id)
          .toList();
      groupInfoModel.add(
        GroupInfoModel(groupModel: item, appointmentModel: newAppointmentList),
      );
    }

    return groupInfoModel;
  }

  Future<List<AppointmentModel>> getSearchAppointmentList(
    String groupId,
  ) async {
    List<AppointmentModel> appointmnetList = [];

    List appointment = await search(
      groupId.toString(),
      SqfliteDataBase.appointmentGroupsId,
      SqfliteDataBase.appointmentTable,
    );

    for (var item in appointment) {
      appointmnetList.add(AppointmentModel.fromJson(item));
    }
    //  listEducation += data.map((e) => EducationModel.fromJson(e)).toList();

    return appointmnetList;
  }
}
