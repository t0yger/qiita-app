import 'package:qiita_app/data/entities/article.dart';
import 'package:qiita_app/domain/repositories/articles_repository.dart';
import 'package:qiita_app/domain/usecases/articles_usecase.dart';

class ArticlesInteracotr extends ArticlesUsecase {
  final ArticlesRepository _repository;
  ArticlesInteracotr(this._repository);

  @override
  Future<List<Article>> getArticles(String pageKey, String perPage) async {
    return _repository.getAllArticles(pageKey, perPage);
  }
}
