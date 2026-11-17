import 'package:drosak_app/core/Database/sqflite/sqflite_data_base.dart';

class EducationModel {
  final String image;
  final String title;
  final String subTitle;
  final int? id;
  String? creatAt;
  final int status;

  EducationModel({
    required this.image,
    required this.title,
    required this.subTitle,
    this.id,
    this.creatAt,
    this.status = 1,
  });

  @override
  String toString() {
    return 'EducationModel( id: $id image: $image, title: $title, subTitle: $subTitle , status: $status)';
  }

  Map<String, dynamic> toJson() {
    return {
      SqfliteDataBase.educationStageName: title,
      SqfliteDataBase.educationStageDesc: subTitle,
      SqfliteDataBase.educationStageImage: image,
    };
  }

  factory EducationModel.fromJson(Map json) {
    return EducationModel(
      image: json[SqfliteDataBase.educationStageImage].toString(),
      title: json[SqfliteDataBase.educationStageName].toString(),
      subTitle: json[SqfliteDataBase.educationStageDesc].toString(),
      id: int.parse(json[SqfliteDataBase.educationStageId].toString()),
      creatAt: json[SqfliteDataBase.educationalStageCreatedAt].toString(),
      status: int.parse(
        json[SqfliteDataBase.educationalStageStatus].toString(),
      ),
    );
  }
}
