import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import './components/scan_qr/scan_manager.dart';
import 'package:safe_chair/ui_elements/toast.dart';
import 'package:safe_chair/services/api.dart' as api;

class ChairManagePage extends StatefulWidget {
  @override
  _ChairManagePageState createState() => _ChairManagePageState();
}

class _ChairManagePageState extends State<ChairManagePage> {
  MainModel _model;
  List<Map<String, String>> deviceList = [
    {'model': 'CN08', 'name': '茧之爱2'},
    {'model': 'CN06', 'name': '茧之爱'},
  ];
  
  @override
  void initState() {
    _model = ScopedModel.of(context);
    super.initState();
  }

  Widget _buildList() {
    final Color primaryColor = Theme.of(context).primaryColor;
    List<Widget> _list = [];
    for (var item in deviceList) {
      var listItem = ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(item['model'], style: TextStyle(color: primaryColor)),
            Text(item['name'], style: TextStyle(color: primaryColor)),
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: primaryColor),
      );
      _list.add(listItem);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _list,
      ),
    );
  }

  Widget _buildAddBtn() {
    return BasicBtn(
      label: '添加座椅',
      onTap: () {
        print('add chair');
        ScanManager.start(context).then((uuid) {
          print('qr: $uuid');
          if (uuid is String && uuid != null) {
            getChairInfo(uuid);
          }
        });
      },
    );
  }

  void getChairInfo(String uuid) async {
    try {
      final Map<String, dynamic> response =
          await api.post(context, api: '/device/get_info_by_uuid', body: {
        'token': _model.authUser.token,
        'uuid': uuid,
      });
      print('r: $response');
    } catch (e) {
      print(e);
      Toast.show(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          '座椅管理',
          style: TextStyle(color: primaryColor),
        ),
        iconTheme: IconThemeData(color: primaryColor),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                _buildList(),
                SizedBox(height: 20),
                _buildAddBtn(),
                SizedBox(height: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
