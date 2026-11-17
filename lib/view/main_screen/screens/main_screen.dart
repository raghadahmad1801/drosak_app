import 'package:drosak_app/controller/main/main_controller.dart';
import 'package:drosak_app/view/main_screen/widgets/bottomNav/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainScreen> {
  late MainController mainController;
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainController = MainController();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    mainController.getArguments(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNav(
        onTap: (value) {
          mainController.onTap(value);
        },
        streamOutput: mainController.outputNav,
        listMain: mainController.navList,
      ),
      body: StreamBuilder(
        stream: mainController.outputBody,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return mainController.navList[asyncSnapshot.data!].screen;
          }
        },
      ),
    );
  }
}
