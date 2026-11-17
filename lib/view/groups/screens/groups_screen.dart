import 'package:drosak_app/controller/groups/groups_controller.dart';
import 'package:drosak_app/core/Database/sqflite/group_operatin.dart';
import 'package:drosak_app/model/group_info/group_info_model.dart';
import 'package:drosak_app/view/education/widgets/app_bar/custom_app_bar.dart';
import 'package:drosak_app/view/education/widgets/search/custom_search.dart';
import 'package:drosak_app/view/groups/widgets/body/custom_item_list_group.dart';
import 'package:drosak_app/view/groups/widgets/search/custom_search_group.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<GroupsScreen> {
  late GroupsController groupsController;
  @override
  void initState() {
    groupsController = GroupsController(context);

    super.initState();
  }

  @override
  void dispose() {
    groupsController.disposeController();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "المجموعات",
        onTap: () {
          groupsController.onTap(context);
        },
        onTapSearch: () {
          groupsController.showSearchDelegate();
        },
        count: groupsController.listGroupInfoOutput,
      ),
      body: StreamBuilder<List<GroupInfoModel>>(
        stream: groupsController.listGroupInfoOutput,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                groupsController.onRefresh();
              },
              child: ListView.builder(
                itemCount: asyncSnapshot.data!.length,
                itemBuilder: (context, index) {
                  return CustomItemListGroup(
                    groupInfo: asyncSnapshot.data![index],
                    deleteFun: groupsController.deletefunGroupInfo,
                    editFun: groupsController.editFunction,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
