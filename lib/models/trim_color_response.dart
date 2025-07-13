class TrimColorResponse {
  int? status;
  String? message;
  String? count;
  List<TrimColors>? trimColors;

  TrimColorResponse({this.status, this.message, this.count, this.trimColors});

  TrimColorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['trimColors'] != null) {
      trimColors = <TrimColors>[];
      json['trimColors'].forEach((v) {
        trimColors!.add(new TrimColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.trimColors != null) {
      data['trimColors'] = this.trimColors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrimColors {
  String? id;
  String? description;
  String? carBasePrices;
  String? cars;

  TrimColors({this.id, this.description, this.carBasePrices, this.cars});

  TrimColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    carBasePrices = json['carBasePrices'];
    cars = json['cars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['carBasePrices'] = this.carBasePrices;
    data['cars'] = this.cars;
    return data;
  }
}
