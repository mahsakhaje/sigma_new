class ChassiInquiryResponse {
  int? status;
  String? message;
  String? brandId;
  String? carModelId;
  String? carTypeId;
  String? manufactureYearId;
  String? colorId;
  String? trimColorId;

  ChassiInquiryResponse(
      {this.status,
        this.message,
        this.brandId,
        this.carModelId,
        this.carTypeId,
        this.manufactureYearId,
        this.colorId,
        this.trimColorId});

  ChassiInquiryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    brandId = json['brandId'];
    carModelId = json['carModelId'];
    carTypeId = json['carTypeId'];
    manufactureYearId = json['manufactureYearId'];
    colorId = json['colorId'];
    trimColorId = json['trimColorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['brandId'] = this.brandId;
    data['carModelId'] = this.carModelId;
    data['carTypeId'] = this.carTypeId;
    data['manufactureYearId'] = this.manufactureYearId;
    data['colorId'] = this.colorId;
    data['trimColorId'] = this.trimColorId;
    return data;
  }
}
