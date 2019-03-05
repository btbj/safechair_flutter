import 'package:flutter/material.dart';
import 'dart:async';

class AlertView {
  String msg;

  Future show(BuildContext context, String msg) {
    this.msg = msg;
    return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: _buildView,
    );
  }

  Widget _buildView(BuildContext context) {
    Widget _buildBox({double height, double width, Offset offset}) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(color: Colors.red, blurRadius: 30, spreadRadius: 10, offset: offset)
          ],
        ),
      );
    }

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
                  child: RaisedButton(
                    child: Text('close'),
                    onPressed: () {
                      print('alert close');
                      Navigator.of(context).pop();
                    },
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
