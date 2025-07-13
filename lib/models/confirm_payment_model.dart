class ConfirmPaymentResponse {
  int? status;
  String? message;
  String? orderNumber;

  ConfirmPaymentResponse({this.status, this.message, this.orderNumber});

  ConfirmPaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderNumber = json['orderNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['orderNumber'] = this.orderNumber;
    return data;
  }
}
