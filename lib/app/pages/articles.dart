import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qiita_app/data/entities/article_list_item.dart';
import 'package:qiita_app/domain/usecases/articles_usecase.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'article.dart';

class Articles extends StatefulWidget {
  const Articles({super.key, required this.title, required this.usecase});
  final String title;
  final ArticlesUsecase usecase;

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  static const _perPage = 20;

  final PagingController<int, ArticleListItem> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> getArticles(int pageKey) async {
    try {
      final articleListItems = await widget.usecase
          .getArticles(pageKey.toString(), _perPage.toString());
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

  void onTapItem(ArticleListItem item) {
    if (item.url == null) {
      Fluttertoast.showToast(
          msg: "err: url does not exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    Navigator.pushNamed(
      context,
      ArticleWebView.routeName,
      arguments: ArticleArguments(item.url!),
    );
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
                onTap: () => onTapItem(item),
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(item.profileImageUrl)),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.tags,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.grey),
                                )),
                            const SizedBox(height: 8),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.body,
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
