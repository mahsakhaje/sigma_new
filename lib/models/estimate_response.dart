class EstimateResponse {
  int? status;
  String? message;
  String? maxPrice;
  String? price;
  String? minPrice;

  EstimateResponse(
      {this.status, this.message, this.maxPrice, this.price, this.minPrice});

  EstimateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    maxPrice = json['maxPrice'];
    price = json['price'];
    minPrice = json['minPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['maxPrice'] = this.maxPrice;
    data['price'] = this.price;
    data['minPrice'] = this.minPrice;
    return data;
  }
}
