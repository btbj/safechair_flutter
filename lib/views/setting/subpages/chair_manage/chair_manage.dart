import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';

class ChairManagePage extends StatefulWidget {
  @override
  _ChairManagePageState createState() => _ChairManagePageState();
}

class _ChairManagePageState extends State<ChairManagePage> {
  List<Map<String, String>> deviceList = [
    {'model': 'CN08', 'name': '茧之爱2'},
    {'model': 'CN06', 'name': '茧之爱'},
  ];

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
        deviceList.add({'model': 'asdf', 'name': 'sadfff'});
        setState(() {});
      },
    );
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
