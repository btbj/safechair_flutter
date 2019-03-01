import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import './components/scan_qr/scan_manager.dart';
import 'package:safe_chair/ui_elements/toast.dart';
import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/models/Chair.dart';
import 'package:safe_chair/store/chairStore.dart';

class ChairManagePage extends StatefulWidget {
  @override
  _ChairManagePageState createState() => _ChairManagePageState();
}

class _ChairManagePageState extends State<ChairManagePage> {
  MainModel _model;
  List<Chair> chairList = [];

  @override
  void initState() {
    super.initState();
    _model = ScopedModel.of(context);
    initChairData();
  }

  void initChairData() async {
    final Map<String, dynamic> chairMap = await ChairStore.getChairMap();
    chairList.clear();
    for (var item in chairMap.values) {
      chairList.add(
        Chair(uuid: item['uuid'], name: item['name'], model: item['model']),
      );
    }
    setState(() {});
  }

  Widget _buildList() {
    final Color primaryColor = Theme.of(context).primaryColor;
    List<Widget> _list = [];
    for (Chair chair in chairList) {
      bool isCurrent =
          _model.currentChair != null && _model.currentChair.uuid == chair.uuid;

      Widget checkBox = GestureDetector(
        child: isCurrent
            ? Icon(Icons.check_box, color: primaryColor)
            : Icon(Icons.check_box_outline_blank, color: primaryColor),
        onTap: () async {
          await _model.setCurrentChair(chair);
          setState(() {});
        },
      );

      Widget deleteIcon = GestureDetector(
        child: Icon(Icons.delete, color: Colors.red),
        onTap: () async {
          print('delete');
          await ChairStore.removeChair(chair);
          initChairData();
          setState(() {});
        },
      );

      var listItem = ListTile(
        leading: checkBox,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(chair.model, style: TextStyle(color: primaryColor)),
            Text(chair.name, style: TextStyle(color: primaryColor)),
          ],
        ),
        trailing: deleteIcon,
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
      if (response['data']['product'] == null) {
        Toast.show(context, '未找到产品');
        return;
      }
      final Chair chair = Chair(
        uuid: uuid,
        name: response['data']['product']['name'],
        model: response['data']['product']['model'],
      );
      await ChairStore.saveChair(chair);
      initChairData();
      Toast.show(context, '添加成功');
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
