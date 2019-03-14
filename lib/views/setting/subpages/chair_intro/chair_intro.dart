import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/ui_elements/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class ChairIntroPage extends StatefulWidget {
  @override
  _ChairIntroPageState createState() => _ChairIntroPageState();
}

class _ChairIntroPageState extends State<ChairIntroPage> {
  MainModel _model;
  Map<String, String> chairInfo = {
    'name': '',
    'model': '',
    'useful_area': '',
    'setup_type': '',
    'setup_video_url': null,
    'en_name': '',
    'en_model': '',
    'en_useful_area': '',
    'en_setup_type': '',
    'en_setup_video_url': null
  };

  @override
  void initState() {
    _model = ScopedModel.of(context);
    _getDeviceInfo();
    super.initState();
  }

  void _getDeviceInfo() async {
    print('get device info');
    if (_model.currentChair == null) return;
    try {
      final Map<String, dynamic> response = await api.post(
        context,
        api: '/device/get_info_by_uuid',
        body: {
          'token': _model.authUser.token,
          'uuid': _model.currentChair.uuid,
        },
      );
      print('r: $response');
      if (response['data']['product'] == null) {
        Toast.show(
          context,
          CustomLocalizations.of(context).message('no_product'),
        );
        return;
      }
      chairInfo['name'] = response['data']['product']['name'];
      chairInfo['model'] = response['data']['product']['model'];
      chairInfo['useful_area'] = response['data']['product']['useful_area'];
      chairInfo['setup_type'] = response['data']['product']['setup_type'];
      chairInfo['setup_video_url'] =
          response['data']['product']['setup_video_url'];
      chairInfo['en_name'] = response['data']['product']['en_name'];
      chairInfo['en_model'] = response['data']['product']['en_model'];
      chairInfo['en_useful_area'] =
          response['data']['product']['en_useful_area'];
      chairInfo['en_setup_type'] = response['data']['product']['en_setup_type'];
      chairInfo['en_setup_video_url'] =
          response['data']['product']['en_setup_video_url'];
      setState(() {});
      Toast.show(context, response['message']);
    } catch (e) {
      print(e);
      Toast.show(context, e);
    }
  }

  Widget _buildVideoBtn() {
    Function onTap;
    final String url = _model.isEN
        ? chairInfo['en_setup_video_url']
        : chairInfo['setup_video_url'];
    if (url != null) {
      onTap = () async {
        print('check video: ' + url);
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          Toast.show(
            context,
            CustomLocalizations.of(context).message('url_invalid'),
          );
        }
      };
    }
    return BasicBtn(
      label: CustomLocalizations.of(context).system('install_video_btn_text'),
      onTap: onTap,
    );
  }

  Widget _buildLine(String title, String info) {
    final TextStyle textStyle = TextStyle(color: Colors.grey);
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: textStyle),
          Text(info, style: textStyle),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          _buildLine(CustomLocalizations.of(context).system('chair_name_label'),
              _model.isEN ? chairInfo['en_name'] : chairInfo['name']),
          _buildLine(
              CustomLocalizations.of(context).system('chair_model_label'),
              _model.isEN ? chairInfo['en_model'] : chairInfo['model']),
          _buildLine(
              CustomLocalizations.of(context).system('chair_range_label'),
              _model.isEN
                  ? chairInfo['en_useful_area']
                  : chairInfo['useful_area']),
          _buildLine(
              CustomLocalizations.of(context).system('chair_install_label'),
              _model.isEN
                  ? chairInfo['en_setup_type']
                  : chairInfo['setup_type']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicPlate(
      title: CustomLocalizations.of(context).system('chair_intro_title'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          _buildInfoBox(),
          SizedBox(height: 20),
          _buildVideoBtn(),
        ],
      ),
    );
  }
}
