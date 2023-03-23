import 'package:qiita_app/data/entities/article_list_item.dart';

abstract class ArticlesUsecase {
  Future<List<ArticleListItem>> getArticles(String pageKey, String perPage);
}
