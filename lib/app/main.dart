import 'package:flutter/material.dart';
import 'package:qiita_app/adapter/interactors/articles_interactor.dart';
import 'package:qiita_app/app/pages/article.dart';
import 'package:qiita_app/app/pages/articles.dart';
import 'package:qiita_app/infrastructure/repositories/qiita_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      routes: {ArticleWebView.routeName: (context) => const ArticleWebView()},
      home: Articles(
        title: '記事一覧',
        usecase: ArticlesInteracotr(QiitaRepository()),
      ),
    );
  }
}
