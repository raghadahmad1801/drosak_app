import 'package:drosak_app/core/Database/sqflite/sqflite_data_base.dart';

class GroupModel {
  final String name;
  final String desc;
  final int? id;
  final int educationId;

  GroupModel({
    required this.name,
    required this.desc,
    this.id,
    required this.educationId,
  });

  @override
  String toString() {
    return "GroupModel(name: $name, desc: $desc, id: $id, educationId: $educationId)";
  }

  Map<String, dynamic> toJson() {
    return {
      SqfliteDataBase.groupsName: name,
      SqfliteDataBase.groupsNote: desc,
      SqfliteDataBase.groupsEducationId: educationId,
    };
  }

  factory GroupModel.fromJson(Map json) {
    return GroupModel(
      name: json[SqfliteDataBase.groupsName].toString(),
      desc: json[SqfliteDataBase.groupsNote].toString(),
      educationId: int.parse(
        json[SqfliteDataBase.groupsEducationId].toString(),
      ),

      id: int.parse(json[SqfliteDataBase.groupsId].toString()),
    );
  }
}
