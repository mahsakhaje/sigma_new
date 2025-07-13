class ContactUsResponse {
  int? status;
  String? message;
  String? address;
  String? showRoomAddress;
  String? suggestionNumber;
  String? telephone;
  String? supportTelephone;
  String? showRoomTelephone;
  String? messageNumber;
  String? email;

  ContactUsResponse(
      {this.status,
      this.message,
      this.address,
      this.telephone,
      this.suggestionNumber,
      this.supportTelephone,
      this.showRoomTelephone,
      this.messageNumber,
      this.email});

  ContactUsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    address = json['address'];
    suggestionNumber = json['suggestionNumber'];
    showRoomAddress = json['showRoomAddress'];
    telephone = json['telephone'];
    supportTelephone = json['supportTelephone'];
    showRoomTelephone = json['showRoomTelephone'];
    messageNumber = json['messageNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['address'] = this.address;
    data['telephone'] = this.telephone;
    data['supportTelephone'] = this.supportTelephone;
    data['showRoomTelephone'] = this.showRoomTelephone;
    data['messageNumber'] = this.messageNumber;
    data['email'] = this.email;
    return data;
  }
}
