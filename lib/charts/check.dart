import 'package:flutter/material.dart';

class ColorPalette {
  static Color backGroundColor = const Color(0xFFecf1f4);
  static Color mainColor = const Color(0xf2C86733);
  static Color green = const Color(0xFF73be93);
  static Color idColor = const Color(0xFF9ca2ac);
  static Color selectBackground = const Color(0xFFf1f4f8);
  static Color selectColor = const Color(0xFF6f7c8b);
  static Color halfOval = const Color(0xFF646f80);
  static Color cancelColor = const Color(0xFF3c4b60);
}

class AppButton extends StatelessWidget {
  final String? text;
  final Color backgroundColor;
  final Color iconColor;
  final Color? textColor;
  final IconData iconData;
  final Function() onTap;

  const AppButton(
      {Key? key,
        this.text,
        required this.backgroundColor,
        required this.iconColor,
        this.textColor,
        required this.iconData,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: Icon(
              iconData,
              size: 30,
              color: iconColor,
            ),
          ),
          if (text != null)
            Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  text!,
                  style: TextStyle(color: textColor, fontSize: 14),
                ),
              ],
            )
        ],
      ),
    );
  }
}
