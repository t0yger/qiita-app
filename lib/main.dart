import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qiita_app/article.dart';
import 'package:qiita_app/article_list_item.dart';

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
      home: const MyHomePage(title: '記事一覧'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _perPage = 20;

  final PagingController<int, ArticleListItem> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> getArticles(int pageKey) async {
    print(pageKey);
    try {
      var url = Uri.https('qiita.com', 'api/v2/items',
          {'page': '$pageKey', 'per_page': '$_perPage'});
      var response = await http.get(url);
      final newItems = jsonDecode(response.body);
      final articleListItems = newItems
          .map((item) => ArticleListItem.fromJson(item))
          .cast<ArticleListItem>()
          .toList();
      final isLastPage = articleListItems.length < _perPage;
      if (isLastPage) {
        _pagingController.appendLastPage(articleListItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(articleListItems, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController
        .addPageRequestListener((pageKey) => {getArticles(pageKey)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PagedListView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ArticleListItem>(
            itemBuilder: (context, item, index) => InkWell(
                onTap: () => Navigator.pushNamed(
                      context,
                      ArticleWebView.routeName,
                      arguments: ArticleArguments(item.url ?? ""),
                    ),
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage(item.profileImageUrl ?? "")),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.title ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.tags ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.grey),
                                )),
                            const SizedBox(height: 8),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.body ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ))),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
    );
  }
}
