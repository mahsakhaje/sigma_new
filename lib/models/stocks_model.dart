class StocksResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<Stocks>? stocks;

  StocksResponse(
      {this.status,
        this.message,
        this.persianMessage,
        this.count,
        this.stocks});

  StocksResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(new Stocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stocks {
  String? mileage;
  String? persianYear;
  String? count;
  String? brand;
  String? carModel;
  String? carType;

  Stocks(
      {this.mileage,
        this.persianYear,
        this.count,
        this.brand,
        this.carModel,
        this.carType});

  Stocks.fromJson(Map<String, dynamic> json) {
    mileage = json['mileage'];
    persianYear = json['persianYear'];
    count = json['count'];
    brand = json['brand'];
    carModel = json['carModel'];
    carType = json['carType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mileage'] = this.mileage;
    data['persianYear'] = this.persianYear;
    data['count'] = this.count;
    data['brand'] = this.brand;
    data['carModel'] = this.carModel;
    data['carType'] = this.carType;
    return data;
  }
}
