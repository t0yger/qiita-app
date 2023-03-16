import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qiita_app/data/entities/article.dart';
import 'package:qiita_app/domain/repositories/articles_repository.dart';
import 'package:qiita_app/infrastructure/models/get_qiita_articles_response.dart';

class QiitaRepository extends ArticlesRepository {
  @override
  Future<List<Article>> getAllArticles(String pageKey, String perPage) async {
    try {
      var url = Uri.https(
          'qiita.com', 'api/v2/items', {'page': pageKey, 'per_page': perPage});
      var response = await http.get(url);
      final getQiitaArticlesResponse =
          jsonDecode(response.body) as GetQiitaArticlesResponse;
      return getQiitaArticlesResponse.items.map((item) {
        final tags = item.tags?.map((tag) => tag.name).join(',');
        return Article(
            item.body, tags, item.title, item.url, item.user?.profileImageUrl);
      }).toList();
    } catch (error) {
      rethrow;
    }
  }
}
