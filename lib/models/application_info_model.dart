class ApplicationsInfoResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<Infos>? infos;

  ApplicationsInfoResponse(
      {this.status, this.message, this.persianMessage, this.count, this.infos});

  ApplicationsInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['infos'] != null) {
      infos = <Infos>[];
      json['infos'].forEach((v) {
        infos!.add(new Infos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.infos != null) {
      data['infos'] = this.infos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Infos {
  String? id;
  String? description;
  String? application;
  String? web;
  String? docId;
  String? show;
  String? enable;
  String? popup;
  String? isActive;
  String? url;
  String? currentTab;
  String? document;

  Infos(
      {this.id,
        this.description,
        this.application,
        this.web,
        this.docId,
        this.show,
        this.enable,
        this.popup,
        this.isActive,
        this.url,
        this.currentTab,
        this.document});

  Infos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    application = json['application'];
    web = json['web'];
    docId = json['docId'];
    show = json['show'];
    enable = json['enable'];
    popup = json['popup'];
    isActive = json['isActive'];
    url = json['url'];
    currentTab = json['currentTab'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['application'] = this.application;
    data['web'] = this.web;
    data['docId'] = this.docId;
    data['show'] = this.show;
    data['enable'] = this.enable;
    data['popup'] = this.popup;
    data['isActive'] = this.isActive;
    data['url'] = this.url;
    data['currentTab'] = this.currentTab;
    data['document'] = this.document;
    return data;
  }
}
