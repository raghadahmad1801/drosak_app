import 'package:drosak_app/controller/education/education_controller.dart';
import 'package:drosak_app/model/education/education_model.dart';
import 'package:drosak_app/view/education/widgets/app_bar/custom_app_bar.dart';
import 'package:drosak_app/view/education/widgets/body/custom_item_list.dart';
import 'package:drosak_app/view/education/widgets/search/custom_search.dart';
import 'package:flutter/material.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EducationScreen> {
  late EducationController educationController;
  @override
  void initState() {
    // TODO: implement initState
    educationController = EducationController();
    super.initState();
  }

  @override
  void dispose() {
    educationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // void loadData() async {
  //   await educationController.selectEductionStage();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(
        onTapSearch: () {
          educationController.showSeacrh(context);
        },
        text: "المراحل التعليمية",
        onTap: () {
          educationController.educationshowModalSheet(context);
        },
        count: educationController.listEducationOutput,
      ),

      body: StreamBuilder<List<EducationModel>>(
        stream: educationController.listEducationOutput,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: asyncSnapshot.data!.length,
              itemBuilder: (context, index) {
                return CustomItemList(
                  educationModel: asyncSnapshot.data == null
                      ? asyncSnapshot.data![index]
                      : educationController.listEducatin[index],
                  deleteFun: educationController.delete,
                  editFun: (EducationModel educationModel) {
                    return educationController.editItem(
                      context,
                      educationModel,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
