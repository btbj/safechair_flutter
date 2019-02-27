import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget suffix;

  InputBox({
    this.controller,
    this.icon,
    this.hintText,
    this.obscureText = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final double fontSize = 16;
    final bool hasSuffix = suffix != null;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 15.0),
          Icon(icon, color: primaryColor),
          SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: primaryColor, fontSize: fontSize),
              cursorColor: primaryColor,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: fontSize)),
              obscureText: obscureText,
            ),
          ),
          hasSuffix ? suffix : Container()
        ],
      ),
    );
  }
}
