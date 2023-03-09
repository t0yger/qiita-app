class ArticleListItem {
  final String? body;
  final String? tags;
  final String? title;
  final String? url;
  final String? profileImageUrl;

  ArticleListItem(
      this.body, this.tags, this.title, this.url, this.profileImageUrl);

  factory ArticleListItem.fromJson(Map<String, dynamic> json) =>
      ArticleListItem(
          json['body'],
          json['tags'].map((tag) => tag['name']).join(','),
          json['title'],
          json['url'],
          json['user']['profile_image_url']);
}
