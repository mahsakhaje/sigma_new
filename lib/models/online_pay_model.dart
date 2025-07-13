class OnlinePayResponse {
  int? status;
  String? message;
  String? bankUrl;

  OnlinePayResponse({this.status, this.message, this.bankUrl});

  OnlinePayResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    bankUrl = json['bankUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['bankUrl'] = this.bankUrl;
    return data;
  }
}
