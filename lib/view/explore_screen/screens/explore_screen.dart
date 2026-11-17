import 'package:drosak_app/controller/explore/explore_controller.dart';
import 'package:drosak_app/core/resources/const_value_manger.dart';
import 'package:drosak_app/view/explore_screen/widgets/custom_grid_view.dart';
import 'package:drosak_app/view/explore_screen/widgets/custom_item_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ExploreScreen> {
  late ExploreController exploreController;

  @override
  void initState() {
    // TODO: implement initState
    exploreController = ExploreController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          child: Container(
            width: double.infinity,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "إستكشف التطبيق",
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontFamily: "GE-Dinar",
                    color: Color(0xff8012DC),
                  ),
                ),

                Gap(10.h),

                CustomGridView(
                  onTap: (index) {
                    exploreController.goToMainScreen(context, index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
