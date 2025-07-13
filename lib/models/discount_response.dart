class DiscountResponse {
  int? status;
  String? message;
  String? discountValue;

  DiscountResponse({this.status, this.message, this.discountValue});

  DiscountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    discountValue = json['discountValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['discountValue'] = this.discountValue;
    return data;
  }
}
