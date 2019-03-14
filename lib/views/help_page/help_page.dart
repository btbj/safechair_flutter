import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/head_bar.dart';
import './components/title_btn.dart';
import './assets/help_docs_zh.dart' as zh;
import './assets/help_docs_en.dart' as en;
import 'package:safe_chair/lang/custom_localization.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class HelpPage extends StatelessWidget {
  Widget _buildList(List<Map<String, String>> articles) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return TitleBtn(
              title: articles[index]['title'],
              content: articles[index]['content'],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      List articles = model.isEN ? en.articles : zh.articles;
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              HeadBar(
                title: CustomLocalizations.of(context).system('help_title'),
              ),
              _buildList(articles),
            ],
          ),
        ),
      );
    });
  }
}
