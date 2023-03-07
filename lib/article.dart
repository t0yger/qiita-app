import 'package:flutter/material.dart';

class ArticleArguments {
  final String url;

  ArticleArguments(this.url);
}

class ArticleWebView extends StatelessWidget {
  const ArticleWebView({super.key});

  static const routeName = '/article';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ArticleArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('article'),
      ),
      body: Center(
        child: Text(args.url),
      ),
    );
  }
}
