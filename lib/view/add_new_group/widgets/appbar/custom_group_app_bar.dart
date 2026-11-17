import 'package:flutter/material.dart';

class CustomGroupAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomGroupAppBar({
    super.key,
    required this.title,
    required this.addOrUpdate,
    required this.onPressed,
  });
  final String title;
  final String addOrUpdate;
  final VoidCallback onPressed;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontFamily: "GE-Dinar"),
      ),
      backgroundColor: Color(0xff8012DC),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            addOrUpdate,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: "GE-Dinar",
            ),
          ),
        ),
      ],
    );
  }
}
