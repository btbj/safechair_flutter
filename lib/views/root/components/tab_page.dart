import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:safe_chair/ui_elements/toast.dart';
import '../../chair_page/chair_page.dart';
import '../../web_page/web_page.dart';
import '../../tmall_page/tmall_page.dart';
import '../../help_page/help_page.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _tabIndex = 0;

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
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        activeColor: Theme.of(context).primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.child_care), title: Text('座椅控制')),
          BottomNavigationBarItem(icon: Icon(Icons.web), title: Text('官网')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_mall), title: Text('天猫')),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline), title: Text('帮助')),
        ],
        currentIndex: _tabIndex,
        onTap: _changeTabPage,
      ),
    );
  }
}
