class ColorResponse {
  int? status;
  String? message;
  String? count;
  List<Colors1>? colors;

  ColorResponse({this.status, this.message, this.count, this.colors});

  ColorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['colors'] != null) {
      colors = <Colors1>[];
      json['colors'].forEach((v) {
        colors!.add(new Colors1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colors1 {
  String? id;
  String? description;
  String? colorCode;
  String? cars;
  String? carBasePrices;

  Colors1(
      {this.id,
        this.description,
        this.colorCode,
        this.cars,
        this.carBasePrices});

  Colors1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    colorCode = json['colorCode'];
    cars = json['cars'];
    carBasePrices = json['carBasePrices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['colorCode'] = this.colorCode;
    data['cars'] = this.cars;
    data['carBasePrices'] = this.carBasePrices;
    return data;
  }
}
