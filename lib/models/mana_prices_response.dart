class ManaPricesResponse {
  int? status;
  String? message;
  String? count;
  List<ManaPrices>? manaPrices;

  ManaPricesResponse({this.status, this.message, this.count, this.manaPrices});

  ManaPricesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['manaPrices'] != null) {
      manaPrices = <ManaPrices>[];
      json['manaPrices'].forEach((v) {
        manaPrices!.add(new ManaPrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.manaPrices != null) {
      data['manaPrices'] = this.manaPrices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManaPrices {
  String? id;
  String? carModel;
  String? carTypeId;
  String? updatePriceDate;
  String? leastPrice;
  String? mostPrice;
  String? imagePath;
  String? isActive;
  String? carModelPersian;
  String? factoryPrice;

  ManaPrices(
      {this.id,
        this.carModel,
        this.updatePriceDate,
        this.leastPrice,
        this.carTypeId,
        this.mostPrice,
        this.imagePath,
        this.factoryPrice,
        this.carModelPersian,
        this.isActive});

  ManaPrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carModel = json['carModel'];
    carTypeId = json['carTypeId'];
    updatePriceDate = json['updatePriceDate'];
    carModelPersian = json['carModelPersian'];
    leastPrice = json['leastPrice'];
    mostPrice = json['mostPrice'];
    factoryPrice = json['companyPrice'];
    imagePath = json['imagePath'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carModel'] = this.carModel;
    data['updatePriceDate'] = this.updatePriceDate;
    data['mostPrice'] = this.mostPrice;
    data['carModelPersian'] = this.carModelPersian;
    data['imagePath'] = this.imagePath;
    data['isActive'] = this.isActive;
    return data;
  }
}
