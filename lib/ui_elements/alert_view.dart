import 'package:flutter/material.dart';
import 'dart:async';
import 'package:safe_chair/lang/custom_localization.dart';

enum AlertType {
  babyInCarWhenLeaving,
  installErr,
  lowBattery,
  highTemp,
  lowTemp,
}

class AlertView {
  String msg;

  Future show(BuildContext context, AlertType type) {
    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));

    this.msg = type.toString();
    switch (type) {
      case AlertType.babyInCarWhenLeaving:
        this.msg = CustomLocalizations.of(context).message('alert_baby_in_car');
        break;
      case AlertType.installErr:
        this.msg = CustomLocalizations.of(context).message('alert_install_err');
        break;
      case AlertType.lowBattery:
        this.msg = CustomLocalizations.of(context).message('alert_low_battery');
        break;
      case AlertType.highTemp:
        this.msg = CustomLocalizations.of(context).message('alert_high_temp');
        break;
      case AlertType.lowTemp:
        this.msg = CustomLocalizations.of(context).message('alert_low_temp');
        break;
      default:
        this.msg = '';
    }
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
                    title: Text(
                      CustomLocalizations.of(context).system('alert_title'),
                    ),
                    children: <Widget>[
                      Container(
                        width: 250,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text(msg, softWrap: true),
                      ),
                      RaisedButton(
                        child: Text(
                          CustomLocalizations.of(context)
                              .system('alert_confirm_btn_text'),
                        ),
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
