import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget {

  VoidCallback onTap;
  String title;
  Color bgColor;
  Color fgColor;
  bool isIcon;
  IconData? mIcon;
  double mWidth;

  AppRoundedButton({
    this.mWidth = double.infinity,
    required this.onTap,
    required this.title,
    this.bgColor = Colors.orange,
    this.fgColor = Colors.white,
    this.isIcon = false,
    this.mIcon
});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor
        ),
          onPressed: onTap,
          child: isIcon ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(mIcon),
              SizedBox(
                width: 11,
              ),
              Text(title)
            ],
          ) : Text(title)),
    );
  }
}
