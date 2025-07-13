class CancelReasonResponse {
  int? status;
  String? message;
  String? count;
  List<CancelReasons>? cancelReasons;

  CancelReasonResponse(
      {this.status, this.message, this.count, this.cancelReasons});

  CancelReasonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['cancelReasons'] != null) {
      cancelReasons = <CancelReasons>[];
      json['cancelReasons'].forEach((v) {
        cancelReasons!.add(new CancelReasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.cancelReasons != null) {
      data['cancelReasons'] =
          this.cancelReasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CancelReasons {
  String? id;
  String? orderType;
  String? description;
  String? account;
  String? hasComment;

  CancelReasons(
      {this.id,
        this.orderType,
        this.description,
        this.account,
        this.hasComment});

  CancelReasons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderType = json['orderType'];
    description = json['description'];
    account = json['account'];
    hasComment = json['hasComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderType'] = this.orderType;
    data['description'] = this.description;
    data['account'] = this.account;
    data['hasComment'] = this.hasComment;
    return data;
  }
}
