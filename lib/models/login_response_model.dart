class LoginResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? token;
  Null? tp;

  LoginResponse({this.status, this.message, this.token, this.tp});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    persianMessage = json['persianMessage'];
    tp = json['tp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['token'] = this.token;
    data['tp'] = this.tp;
    return data;
  }
}
