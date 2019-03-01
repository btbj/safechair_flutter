import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import './components/unit_switch.dart';

class TempSettingPage extends StatefulWidget {
  @override
  _TempSettingPageState createState() => _TempSettingPageState();
}

class _TempSettingPageState extends State<TempSettingPage> {
  bool highTempAlertOn = false;
  bool lowTempAlertOn = false;
  int hightTempLimit = 30;
  int lowTempLimit = 4;
  bool isF = false;

  @override
  void initState() {
    _getTempInfo();
    super.initState();
  }

  void _getTempInfo() {
    print('get temp info');
  }

  String _generateTempString(int temp) {
    if (!isF) return '$temp' + '℃';
    else {
      final int fTemp = (temp * 1.8).round() + 32;
      return '$fTemp' + '℉';
    }
  }

  Widget _buildHightTempLine() {
    final Color primaryColor = Theme.of(context).primaryColor;

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('高温报警', style: TextStyle(color: primaryColor)),
          Text(_generateTempString(hightTempLimit), style: TextStyle(color: primaryColor)),
        ],
      ),
      trailing: Switch(
        value: highTempAlertOn,
        onChanged: (value) {
          setState(() {
            highTempAlertOn = value;
          });
        },
        activeColor: primaryColor,
        inactiveTrackColor: Colors.grey[700],
        inactiveThumbColor: Colors.grey[400],
      ),
    );
  }

  Widget _buildLowTempLine() {
    final Color primaryColor = Theme.of(context).primaryColor;

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('低温报警', style: TextStyle(color: primaryColor)),
          Text(_generateTempString(lowTempLimit), style: TextStyle(color: primaryColor)),
        ],
      ),
      trailing: Switch(
        value: lowTempAlertOn,
        onChanged: (value) {
          setState(() {
            lowTempAlertOn = value;
          });
        },
        activeColor: primaryColor,
        inactiveTrackColor: Colors.grey[700],
        inactiveThumbColor: Colors.grey[400],
      ),
    );
  }

  Widget _buildUnitLine() {
    final Color primaryColor = Theme.of(context).primaryColor;

    return ListTile(
      title: Text('温度单位', style: TextStyle(color: primaryColor)),
      trailing: UnitSwitch(isF: isF, onTap: () {
        setState(() {
          print('change unit');
          isF = !isF;
        });
      },),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          _buildHightTempLine(),
          _buildLowTempLine(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(color: Colors.grey),
          ),
          _buildUnitLine(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicPlate(
      title: '温度设置',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          _buildInfoBox(),
        ],
      ),
    );
  }
}
