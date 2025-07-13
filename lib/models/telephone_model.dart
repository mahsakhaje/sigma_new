class TelephoneResponse {
  int? status;
  String? message;
  String? text;

  TelephoneResponse({this.status, this.message, this.text});

  TelephoneResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['text'] = this.text;
    return data;
  }
}
