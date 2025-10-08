class CarTypeSpecTypeResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<CarTypeSpecTypes>? carTypeSpecTypes;

  CarTypeSpecTypeResponse(
      {this.status,
      this.message,
      this.persianMessage,
      this.count,
      this.carTypeSpecTypes});

  CarTypeSpecTypeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['carTypeSpecTypes'] != null) {
      carTypeSpecTypes = [];
      json['carTypeSpecTypes'].forEach((v) {
        carTypeSpecTypes?.add(new CarTypeSpecTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.carTypeSpecTypes != null) {
      data['carTypeSpecTypes'] =
          this.carTypeSpecTypes?.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class CarTypeSpecTypes {
  String? id;
  String? description;
  String? isDefault;
  String? carTypeId;
  String? carTypeDescription;
  String? specTypeId;
  String? specTypeDescription;
  String? specGroupId;
  String? specGroupDescription;

  CarTypeSpecTypes(
      {this.id,
      this.description,
      this.isDefault,
      this.carTypeId,
      this.carTypeDescription,
      this.specTypeId,
      this.specTypeDescription,
      this.specGroupId,
      this.specGroupDescription});

  CarTypeSpecTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    isDefault = json['isDefault'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    specTypeId = json['specTypeId'];
    specTypeDescription = json['specTypeDescription'];
    specGroupId = json['specGroupId'];
    specGroupDescription = json['specGroupDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['isDefault'] = this.isDefault;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['specTypeId'] = this.specTypeId;
    data['specTypeDescription'] = this.specTypeDescription;
    data['specGroupId'] = this.specGroupId;
    data['specGroupDescription'] = this.specGroupDescription;
    return data;
  }
}
