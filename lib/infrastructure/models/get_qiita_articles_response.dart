class GetQiitaArticlesResponse {
  final List<QiitaArticleResponseData> items;

  GetQiitaArticlesResponse(this.items);
}

class QiitaArticleResponseData {
  final String? renderedBody;
  final String? body;
  final bool? coediting;
  final int? commentsCount;
  final String? createdAt;
  final QiitaGroup? group;
  final String? id;
  final int? likesCount;
  final bool? private;
  final int? reactionsCount;
  final int? stocksCount;
  final List<QiitaTag>? tags;
  final String? title;
  final String? updatedAt;
  final String? url;
  final QiitaUser? user;
  final int? pageViewsCount;
  final QiitaTeamMembership? teamMembership;

  QiitaArticleResponseData(
      this.renderedBody,
      this.body,
      this.coediting,
      this.commentsCount,
      this.createdAt,
      this.group,
      this.id,
      this.likesCount,
      this.pageViewsCount,
      this.private,
      this.reactionsCount,
      this.stocksCount,
      this.tags,
      this.teamMembership,
      this.title,
      this.updatedAt,
      this.url,
      this.user);

  factory QiitaArticleResponseData.fromJson(Map<String, dynamic> json) =>
      QiitaArticleResponseData(
          json['rendered_body'],
          json['body'],
          json['coediting'],
          json['comments_count'],
          json['created_at'],
          QiitaGroup.fromJson(json['group']),
          json['id'],
          json['likes_count'],
          json['page_views_count'],
          json['private'],
          json['reactions_count'],
          json['stocks_count'],
          json['tags']
              .map((tag) => QiitaTag.fromJson(tag))
              .cast<QiitaTag>()
              .toList(),
          QiitaTeamMembership.fromJson(json['team_membership']),
          json['title'],
          json['updated_at'],
          json['url'],
          QiitaUser.fromJson(json['user']));
}

class QiitaTeamMembership {
  final String? name;

  QiitaTeamMembership(this.name);

  factory QiitaTeamMembership.fromJson(Map<String, dynamic>? json) =>
      QiitaTeamMembership(json?['name']);
}

class QiitaTag {
  final String? name;
  final List<String>? versions;
  QiitaTag(this.name, this.versions);
  factory QiitaTag.fromJson(Map<String, dynamic>? json) =>
      QiitaTag(json?['name'], json?['versions'].cast<String>().toList());
}

class QiitaGroup {
  final String? createdAt;
  final String? description;
  final String? name;
  final bool? private;
  final String? updatedAt;
  final String? urlName;
  QiitaGroup(this.createdAt, this.description, this.name, this.private,
      this.updatedAt, this.urlName);

  factory QiitaGroup.fromJson(Map<String, dynamic>? json) => QiitaGroup(
      json?['created_at'],
      json?['description'],
      json?['name'],
      json?['private'],
      json?['updated_at'],
      json?['url_name']);
}

class QiitaUser {
  final String? description;
  final String? facebookId;
  final int? followeesCount;
  final int? followersCount;
  final String? githubLoginName;
  final String? id;
  final int? itemsCount;
  final String? linkedinId;
  final String? location;
  final String? name;
  final String? organization;
  final int? permanentId;
  final String? profileImageUrl;
  final bool? teamOnly;
  final String? twitterScreenName;
  final String? websiteUrl;

  QiitaUser(
      this.description,
      this.facebookId,
      this.followeesCount,
      this.followersCount,
      this.githubLoginName,
      this.id,
      this.itemsCount,
      this.linkedinId,
      this.location,
      this.name,
      this.organization,
      this.permanentId,
      this.profileImageUrl,
      this.teamOnly,
      this.twitterScreenName,
      this.websiteUrl);

  factory QiitaUser.fromJson(Map<String, dynamic>? json) => QiitaUser(
      json?['description'],
      json?['facebook_id'],
      json?['followees_count'],
      json?['followers_count'],
      json?['github_login_name'],
      json?['id'],
      json?['items_count'],
      json?['linkedin_id'],
      json?['location'],
      json?['name'],
      json?['organization'],
      json?['permanent_id'],
      json?['profile_image_url'],
      json?['team_only'],
      json?['twitter_screen_name'],
      json?['website_url)']);
}
