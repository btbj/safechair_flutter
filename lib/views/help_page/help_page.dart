import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/head_bar.dart';
import './components/title_btn.dart';

class HelpPage extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {
      'title': '1. 如何添加座椅？',
      'content': '打开APP->选择左上角设置图标->选择座椅管理->添加座椅->选择座椅型号->设置座椅名称->添加完成'
    },
    {
      'title': '2. 如何修改密码？',
      'content': '打开APP->选择左上角设置图标->密码设置->输入新密码->输入确认密码->修改完成'
    },
    {
      'title': '3. 如何查看座椅安装视频？',
      'content': '打开APP->选择左上角设置图标->选择座椅管理->选择需要查看的已添加座椅->选择安装视频->播放'
    },
    {'title': '4. 如何查看警报状态？', 'content': '图片注释'},
    {
      'title': '5. 如何设置个人信息？',
      'content': '打开APP->选择左上角设置图标->选择个人信息->选择需要添加或修改的个人信息->添加或修改->完成'
    },
    {'title': '6. 座椅使用说明书？', 'content': '文件上传'},
    {'title': '7. 如何联系客服？', 'content': '4008-122-521'},
  ];

  Widget _buildList() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                TitleBtn(
                    title: articles[0]['title'],
                    content: articles[0]['content']),
                TitleBtn(
                    title: articles[1]['title'],
                    content: articles[1]['content']),
                TitleBtn(
                    title: articles[2]['title'],
                    content: articles[2]['content']),
                TitleBtn(
                    title: articles[3]['title'],
                    content: articles[3]['content']),
                TitleBtn(
                    title: articles[4]['title'],
                    content: articles[4]['content']),
                TitleBtn(
                    title: articles[5]['title'],
                    content: articles[5]['content']),
                TitleBtn(
                    title: articles[6]['title'],
                    content: articles[6]['content']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeadBar(title: '帮助'),
            _buildList(),
          ],
        ),
      ),
    );
  }
}
