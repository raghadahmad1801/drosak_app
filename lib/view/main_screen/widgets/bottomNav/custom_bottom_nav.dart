import 'package:drosak_app/model/main/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.onTap,
    required this.streamOutput,
    required this.listMain,
  });
  final ValueChanged<int> onTap;
  final Stream<int> streamOutput;
  final List<MainModel> listMain;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: streamOutput,
      builder: (context, asyncSnapshot) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BottomNavigationBar(
            backgroundColor: Color(0xff18171C),
            currentIndex: asyncSnapshot.data == null ? 0 : asyncSnapshot.data!,
            onTap: (value) {
              onTap(value);
            },
            // unselectedFontSize: 10,
            selectedIconTheme: IconThemeData(color: Color(0xff8012DC)),
            selectedItemColor: Color(0xff8012DC),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: [
              for (int i = 0; i < listMain.length; i++)
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    colorFilter: ColorFilter.mode(
                      asyncSnapshot.data == i ? Color(0xff8012DC) : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    listMain[i].image,
                  ),
                  label: listMain[i].text,
                ),
            ],
          ),
        );
      },
    );
  }
}
