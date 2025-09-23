class BannersResponse {
  int? status;
  String? message;
  String? count;
  String? pelakSefidLink;
  String? instaLink;
  String? aparatLink;
  String? telegramLink;
  String? linkedinLink;
  List<Banners>? banners;

  BannersResponse({this.status,this.linkedinLink, this.message, this.count, this.banners,this.aparatLink,this.instaLink,this.pelakSefidLink,this.telegramLink});

  BannersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    pelakSefidLink = json['pelakSefidLink'];
    instaLink = json['instaLink'];
    aparatLink = json['aparatLink'];
    linkedinLink = json['linkedinLink'];
    telegramLink = json['telegramLink'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? id;
  String? description;
  String? application;
  String? web;
  String? docId;
  String? fromDate;
  String? toDate;
  String? isActive;
  String? url;

  Banners(
      {this.id,
      this.description,
      this.application,
      this.web,
      this.docId,
      this.fromDate,
      this.url,
      this.toDate,
      this.isActive});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    application = json['application'];
    web = json['web'];
    docId = json['docId'];
    url = json['url'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['application'] = this.application;
    data['web'] = this.web;
    data['docId'] = this.docId;
    data['url'] = this.url;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['isActive'] = this.isActive;
    return data;
  }
}
