import 'package:drosak_app/core/resources/const_value_manger.dart'
    show ConstValueManger;
import 'package:drosak_app/view/explore_screen/widgets/custom_item_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key, required this.onTap});
  final Function(int index) onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 34.h,
          crossAxisSpacing: 39.w,
          childAspectRatio: 138.w / 108.h,
        ),
        itemCount: ConstValueManger.exploreListValue.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onTap(index);
            },

            child: CustomItemGridView(
              exploreModel: ConstValueManger.exploreListValue[index],
            ),
          );
        },
      ),
    );
  }
}
