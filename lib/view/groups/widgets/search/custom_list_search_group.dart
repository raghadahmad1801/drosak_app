import 'package:drosak_app/model/group_info/group_info_model.dart';
import 'package:drosak_app/view/groups/widgets/body/custom_item_list_group.dart';
import 'package:flutter/material.dart';

class CustomListSearchGroup extends StatelessWidget {
  final Future<List<GroupInfoModel>> searchList;
  final Function(GroupInfoModel groupInfoModel) deleteFun;
  final Function(GroupInfoModel groupInfoModel) editFun;

  const CustomListSearchGroup({
    super.key,
    required this.searchList,
    required this.deleteFun,
    required this.editFun,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GroupInfoModel>>(
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
            return CustomItemListGroup(
              deleteFun: deleteFun,
              editFun: editFun,
              groupInfo: list[index],
            );
          },
        );
      },
    );
  }
}
