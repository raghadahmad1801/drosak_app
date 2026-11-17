import 'package:drosak_app/model/education/education_model.dart';
import 'package:drosak_app/view/education/widgets/body/custom_item_list.dart';
import 'package:flutter/material.dart';

class CustomListSearch extends StatelessWidget {
  const CustomListSearch({
    super.key,
    required this.searchList,
    required this.deleteFun,
    required this.editFun,
  });

  final Future<List<EducationModel>> searchList;
  final Future<bool> Function(EducationModel educationModel) deleteFun;
  final Future<bool> Function(EducationModel educationModel) editFun;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EducationModel>>(
      future: searchList,
      builder: (context, snapshot) {
        // 1️⃣ أثناء التحميل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2️⃣ لو صار خطأ
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'حدث خطأ أثناء تحميل البيانات',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        // 3️⃣ لو ما في بيانات أو القائمة فاضية
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('لا توجد نتائج', style: TextStyle(color: Colors.white)),
          );
        }

        // 4️⃣ البيانات موجودة ✅
        final list = snapshot.data!;

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CustomItemList(
              educationModel: list[index],
              deleteFun: deleteFun,
              editFun: editFun,
            );
          },
        );
      },
    );
  }
}
