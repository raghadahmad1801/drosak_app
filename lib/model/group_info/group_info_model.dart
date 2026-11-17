import 'package:drosak_app/model/appointment/appointment_model.dart';
import 'package:drosak_app/model/group/group_model.dart';

class GroupInfoModel {
  GroupModel groupModel;
  List<AppointmentModel> appointmentModel;
  GroupInfoModel({required this.groupModel, required this.appointmentModel});
  @override
  String toString() {
    return "GroupInfoModel(groupModel: $groupModel, appointmentModel: $appointmentModel)";
  }
}
