class BlogResponse {
  int? status;
  String? message;
  String? count;
  List<News>? news;

  BlogResponse({this.status, this.message, this.count, this.news});

  BlogResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(new News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.news != null) {
      data['news'] = this.news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String? title;
  String? link;
  String? imageUrl;

  News({this.title, this.link, this.imageUrl});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
