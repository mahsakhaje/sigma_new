class NotifCountResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? text;

  NotifCountResponse(
      {this.status, this.message, this.persianMessage, this.text});

  NotifCountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['text'] = this.text;
    return data;
  }
}
