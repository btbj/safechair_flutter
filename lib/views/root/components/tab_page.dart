import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:safe_chair/ui_elements/toast.dart';
import '../../chair_page/chair_page.dart';
import '../../web_page/web_page.dart';
import '../../tmall_page/tmall_page.dart';
import '../../help_page/help_page.dart';
import './welldon_tab_bar.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _tabIndex = 0;

  MainModel _model;
  @override
  void initState() {
    _model = ScopedModel.of(context);
    _model.alertSubject.listen((String msg) {
      setState(() {
        _tabIndex = 0;
      });
    });
    super.initState();
  }

  void openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show(context, '不能打开网址');
    }
  }

  void _changeTabPage(int index) {
    if (index == 1) {
      print('launch web');
      openUrl('http://www.welldon.net.cn/');
      return;
    }
    if (index == 2) {
      print('launch tmall');
      openUrl('http://welldonqcyp.m.tmall.com/');
      return;
    }
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        children: <Widget>[
          ChairPage(),
          WebPage(),
          TmallPage(),
          HelpPage(),
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: WelldonTabBar(onTap: _changeTabPage),
    );
  }
}
