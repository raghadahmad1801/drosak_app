import 'package:drosak_app/core/Database/sqflite/sqflite_data_base.dart';
import 'package:drosak_app/model/education/education_model.dart';

class EducationStageDataBase extends SqfliteDataBase {
  Future<bool> insertToEducation(EducationModel educationModel) {
    return insert(SqfliteDataBase.educationStagetable, educationModel.toJson());
  }

  Future<List<EducationModel>> selectFromEducation() async {
    List<Map<String, Object?>> data = await select(
      table: SqfliteDataBase.educationStagetable,
      where: " ${SqfliteDataBase.educationalStageStatus} = ?  ",
      whereArgs: ["1"],
    );

    List<EducationModel> listEducation = [];

    for (var item in data) {
      listEducation.add(EducationModel.fromJson(item));
    }
    //  listEducation += data.map((e) => EducationModel.fromJson(e)).toList();

    return listEducation;
  }

  Future<List<EducationModel>> getSearch(word) async {
    List<EducationModel> searchEducation = [];

    List<Map<String, Object?>> searchData = await search(
      word,
      SqfliteDataBase.educationStageName,
      SqfliteDataBase.educationStagetable,
    );

    for (var item in searchData) {
      searchEducation.add(EducationModel.fromJson(item));
    }
    print(searchEducation);

    return searchEducation;
  }

  Future<bool> softDelete(EducationModel educationModel) async {
    return await update(
      SqfliteDataBase.educationStagetable,
      {SqfliteDataBase.educationalStageStatus: 0},
      "${SqfliteDataBase.educationStageId}=?",
      ["${educationModel.id}"],
    );
  }

  Future<bool> edit(EducationModel educationModel) async {
    return await update(
      SqfliteDataBase.educationStagetable,

      educationModel.toJson(),
      "${SqfliteDataBase.educationStageId}=?",
      ["${educationModel.id}"],
    );
  }
}
