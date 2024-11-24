class Reports {
  Reports({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });
  late final int count;
  late final String next;
  late final Null previous;
  late final List<Results> results;

  Reports.fromJson(Map<String, dynamic> json){
    count = json['count'];
    next = json['next'];
    previous = null;
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['next'] = next;
    _data['previous'] = previous;
    _data['results'] = results.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Results {
  Results({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final String url;
  late final String imageUrl;
  late final String newsSite;
  late final String summary;
  late final String publishedAt;
  late final String updatedAt;

  Results.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    url = json['url'];
    imageUrl = json['image_url'];
    newsSite = json['news_site'];
    summary = json['summary'];
    publishedAt = json['published_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['url'] = url;
    _data['image_url'] = imageUrl;
    _data['news_site'] = newsSite;
    _data['summary'] = summary;
    _data['published_at'] = publishedAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}