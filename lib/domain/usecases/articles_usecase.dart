import 'package:qiita_app/data/entities/article.dart';

abstract class ArticlesUsecase {
  Future<List<Article>> getArticles(String pageKey, String perPage);
}
