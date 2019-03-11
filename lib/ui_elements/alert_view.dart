import 'package:flutter/material.dart';
import 'dart:async';

class AlertView {
  String msg;

  Future show(BuildContext context, String msg) {
    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));

    this.msg = msg;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialogBox(msg),
    );
  }
}

class AlertDialogBox extends StatelessWidget {
  final String msg;
  AlertDialogBox(this.msg);

  Widget _buildBox({double height, double width, Offset offset}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.red,
            blurRadius: 30,
            spreadRadius: 10,
            offset: offset,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildBox(height: 1, offset: Offset(0, -20)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildBox(width: 1, offset: Offset(-3, 0)),
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  child: SimpleDialog(
                    contentPadding: EdgeInsets.symmetric(horizontal: 25),
                    title: Text('警告'),
                    children: <Widget>[
                      Container(
                        width: 250,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text(msg, softWrap: true),
                      ),
                      RaisedButton(
                        child: Text('确定'),
                        onPressed: () {
                          print('alert close');
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                _buildBox(width: 1, offset: Offset(3, 0)),
              ],
            ),
          ),
          _buildBox(height: 1, offset: Offset(0, 20)),
        ],
      ),
    );
  }
}
