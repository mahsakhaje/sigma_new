class AboutUsModel {
  int? status;
  String? message;
  AboutUs? aboutUs;

  AboutUsModel({this.status, this.message, this.aboutUs});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    aboutUs =
    json['aboutUs'] != null ? new AboutUs.fromJson(json['aboutUs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.aboutUs != null) {
      data['aboutUs'] = this.aboutUs!.toJson();
    }
    return data;
  }
}

class AboutUs {
  String? content;

  AboutUs({this.content});

  AboutUs.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    return data;
  }
}
