import 'package:flutter/material.dart';

class SliderDialog extends StatefulWidget {
  final String title;
  final bool isF;
  final int initTemp;
  final int max;
  final int min;
  SliderDialog({this.title, this.isF, this.initTemp, this.max, this.min});

  @override
  _SliderDialogState createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  double temp;
  @override
  void initState() {
    temp = widget.initTemp.toDouble();
    super.initState();
  }

  String _generateTempString(int temp) {
    if (!widget.isF)
      return '$temp' + '℃';
    else {
      final int fTemp = (temp * 1.8).round() + 32;
      return '$fTemp' + '℉';
    }
  }

  Widget _buildInfoText() {
    String info = '当前：' + _generateTempString(temp.toInt());
    return Text(info);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.title),
      contentPadding: EdgeInsets.all(15),
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildInfoText(),
            Slider(
              value: temp,
              max: widget.max.toDouble(),
              min: widget.min.toDouble(),
              onChanged: (value) {
                setState(() {
                  temp = value;
                });
              },
            ),
          ],
        ),
        RaisedButton(
          child: Text('确定'),
          onPressed: () {
            print('confirm');
            Navigator.pop(context, temp.toInt());
          },
        ),
      ],
    );
  }
}
