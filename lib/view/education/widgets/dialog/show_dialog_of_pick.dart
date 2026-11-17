import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void showDialogOfPickImage({
  required BuildContext context,
  required VoidCallback onPressedPickCamera,
  required VoidCallback onPressedPickGallery,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: EdgeInsets.only(bottom: 20, top: 5),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton.filled(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
              color: Colors.white,
              iconSize: 15,

              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  onPressed: () {
                    onPressedPickCamera();
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.camera),
                  iconSize: 50,
                ),

                Gap(25),
                IconButton.filled(
                  onPressed: () {
                    onPressedPickGallery();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.photo),
                  iconSize: 50,
                ),
              ],
            ),
          ],
        ),

        //   icon: Icon(Icons.close),
        // iconPadding: EdgeInsets.only(left: 0, top: 10),
      );
    },
  );
}
