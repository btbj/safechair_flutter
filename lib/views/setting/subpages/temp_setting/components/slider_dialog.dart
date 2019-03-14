import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/store/temperatureLimitStore.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class SliderDialog extends StatefulWidget {
  final bool isHigh;
  SliderDialog({this.isHigh});

  @override
  _SliderDialogState createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  MainModel _model;
  double temp;
  @override
  void initState() {
    _model = ScopedModel.of(context);

    temp = widget.isHigh
        ? _model.temperatureLimit.high.toDouble()
        : _model.temperatureLimit.low.toDouble();
    super.initState();
  }

  String _generateTempString(int temp, bool isF) {
    if (!isF)
      return '$temp' + '℃';
    else {
      final int fTemp = (temp * 1.8).round() + 32;
      return '$fTemp' + '℉';
    }
  }

  Widget _buildInfoText() {
    String info =
        CustomLocalizations.of(context).system('current_temp_prefix') +
            _generateTempString(temp.toInt(), _model.temperatureLimit.isF);
    return Text(info);
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.isHigh
        ? CustomLocalizations.of(context)
            .system('high_temperature_setting_dialog_title')
        : CustomLocalizations.of(context)
            .system('low_temperature_setting_dialog_title');
    final int intMax = widget.isHigh ? 50 : _model.temperatureLimit.high;
    final int intMin = widget.isHigh ? _model.temperatureLimit.low : 0;
    return SimpleDialog(
      title: Text(title),
      contentPadding: EdgeInsets.all(15),
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildInfoText(),
            Slider(
              value: temp,
              max: intMax.toDouble(),
              min: intMin.toDouble(),
              onChanged: (value) {
                setState(() {
                  temp = value;
                });
              },
            ),
          ],
        ),
        RaisedButton(
          child: Text(
            CustomLocalizations.of(context).system('confirm_btn_text'),
          ),
          onPressed: () async {
            print('confirm');
            await _model.setTemperatureLimit(TemperatureLimit(
              high: widget.isHigh ? temp.toInt() : _model.temperatureLimit.high,
              low: !widget.isHigh ? temp.toInt() : _model.temperatureLimit.low,
              highSwitch: _model.temperatureLimit.highSwitch,
              lowSwitch: _model.temperatureLimit.lowSwitch,
              isF: _model.temperatureLimit.isF,
            ));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
