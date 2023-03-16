import 'package:qiita_app/data/entities/article.dart';

abstract class ArticlesRepository {
  Future<List<Article>> getAllArticles(String pageKey, String perPage);
}
