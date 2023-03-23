import 'package:qiita_app/data/entities/article_list_item.dart';
import 'package:qiita_app/domain/repositories/articles_repository.dart';
import 'package:qiita_app/domain/usecases/articles_usecase.dart';

class ArticlesInteracotr extends ArticlesUsecase {
  final ArticlesRepository _repository;
  ArticlesInteracotr(this._repository);

  @override
  Future<List<ArticleListItem>> getArticles(
      String pageKey, String perPage) async {
    final articles = await _repository.getAllArticles(pageKey, perPage);
    return articles.map((article) {
      final tags = article.tags?.join(",");
      return ArticleListItem(article.body ?? "", tags ?? "",
          article.title ?? "", article.url, article.profileImageUrl ?? "");
    }).toList();
  }
}
