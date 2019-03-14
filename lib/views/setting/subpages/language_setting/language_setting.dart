import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class LanguageSettingPage extends StatelessWidget {
  Widget _buildChineseLine(BuildContext context, MainModel model) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return ListTile(
      title: Text('中文', style: TextStyle(color: primaryColor, fontSize: 16)),
      trailing: model.isEN ? SizedBox(width: 10) : Icon(Icons.check_circle, color: primaryColor),
      onTap: () {
        if (model.isEN) {
          model.toggleEnglish();
        }
      },
    );
  }

  Widget _buildEnglishLine(BuildContext context, MainModel model) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return ListTile(
      title: Text('English', style: TextStyle(color: primaryColor, fontSize: 16)),
      trailing: !model.isEN ? SizedBox(width: 10) : Icon(Icons.check_circle, color: primaryColor),
      onTap: () {
        if (!model.isEN) {
          model.toggleEnglish();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return BasicPlate(
        title: CustomLocalizations.of(context).system('language_setting_title'),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildChineseLine(context, model),
              _buildEnglishLine(context, model),
            ],
          ),
        ),
      );
    });
  }
}
