import 'package:flutter/material.dart';

class BasicBtn extends StatelessWidget {
  final Function onTap;
  final String label;

  BasicBtn({this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: Theme.of(context).primaryColor),
        color: Theme.of(context).primaryColor,
      ),
      child: FlatButton(
        child: Text(label, style: TextStyle(fontSize: 16)),
        onPressed: onTap,
      ),
    );
  }
}