import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    required this.onTap,
    required this.onTapSearch,
    required this.count,
  });
  final String text;
  final GestureTapCallback onTap;
  final GestureTapCallback onTapSearch;
  final Stream<List> count;
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff8012DC),
      automaticallyImplyLeading: false,
      title: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            StreamBuilder<List>(
              stream: count,
              builder: (context, asyncSnapshot) {
                return Text(
                  text +
                      "(${asyncSnapshot.data == null ? 0 : asyncSnapshot.data!.length})",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: "GE-Dinar",
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: SvgPicture.asset(
                      "assets/images/education_images/add_circle_outline 1.svg",
                    ),
                  ),
                  Gap(10.w),
                  InkWell(
                    onTap: onTapSearch,
                    child: SvgPicture.asset(
                      "assets/images/education_images/zoom 2.svg",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
