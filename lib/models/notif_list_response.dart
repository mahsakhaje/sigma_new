class NotifListResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<AccountNotifs>? accountNotifs;

  NotifListResponse(
      {this.status,
        this.message,
        this.persianMessage,
        this.count,
        this.accountNotifs});

  NotifListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['accountNotifs'] != null) {
      accountNotifs = <AccountNotifs>[];
      json['accountNotifs'].forEach((v) {
        accountNotifs!.add(new AccountNotifs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.accountNotifs != null) {
      data['accountNotifs'] =
          this.accountNotifs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountNotifs {
  String? id;
  String? registerDate;
  String? description;
  String? web;
  String? app;

  AccountNotifs(
      {this.id, this.registerDate, this.description, this.web, this.app});

  AccountNotifs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registerDate = json['registerDate'];
    description = json['description'];
    web = json['web'];
    app = json['app'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['registerDate'] = this.registerDate;
    data['description'] = this.description;
    data['web'] = this.web;
    data['app'] = this.app;
    return data;
  }
}
