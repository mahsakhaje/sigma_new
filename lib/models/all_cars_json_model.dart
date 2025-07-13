class AllCarsJsonModel {
  int? status;
  String? message;
  String? count;
  List<Brands>? brands;

  AllCarsJsonModel({this.status, this.message, this.count, this.brands});

  AllCarsJsonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brands {
  String? id;
  String? description;
  String? isActive;
  List<CarModels>? carModels;

  Brands({this.id, this.description, this.isActive, this.carModels});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    isActive = json['isActive'];
    if (json['carModels'] != null) {
      carModels = <CarModels>[];
      json['carModels'].forEach((v) {
        carModels!.add(new CarModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    if (this.carModels != null) {
      data['carModels'] = this.carModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarModels {
  String? id;
  String? description;
  String? brandId;
  String? brandDescription;
  String? isActive;
  List<CarTypes>? carTypes;
  String? carModelParts;

  CarModels(
      {this.id,
      this.description,
      this.brandId,
      this.brandDescription,
      this.isActive,
      this.carTypes,
      this.carModelParts});

  CarModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    brandId = json['brandId'];
    brandDescription = json['brandDescription'];
    isActive = json['isActive'];
    if (json['carTypes'] != null) {
      carTypes = <CarTypes>[];
      json['carTypes'].forEach((v) {
        carTypes!.add(new CarTypes.fromJson(v));
      });
    }
    carModelParts = json['carModelParts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['brandId'] = this.brandId;
    data['brandDescription'] = this.brandDescription;
    data['isActive'] = this.isActive;
    if (this.carTypes != null) {
      data['carTypes'] = this.carTypes!.map((v) => v.toJson()).toList();
    }
    data['carModelParts'] = this.carModelParts;
    return data;
  }
}

class CarTypes {
  String? id;
  String? description;
  String? carModelId;
  String? carModelDescription;
  String? brandId;
  String? brandDescription;
  String? manufactureYearFrom;
  String? manufactureYearTo;
  String? isActive;
  String? isReal;
  String? cars;
  String? tariffValues;
  String? carBasePrices;
  List<CarTypeManufactureYears>? carTypeManufactureYears;
  List<CarTypeColors>? carTypeColors;
  List<CarTypeTrimColors>? carTypeTrimColors;

  CarTypes(
      {this.id,
      this.description,
      this.carModelId,
      this.carModelDescription,
      this.brandId,
      this.brandDescription,
      this.manufactureYearFrom,
      this.manufactureYearTo,
      this.isActive,
      this.isReal,
      this.cars,
      this.tariffValues,
      this.carBasePrices,
      this.carTypeManufactureYears,
      this.carTypeColors,
      this.carTypeTrimColors});

  CarTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    carModelId = json['carModelId'];
    carModelDescription = json['carModelDescription'];
    brandId = json['brandId'];
    brandDescription = json['brandDescription'];
    manufactureYearFrom = json['manufactureYearFrom'];
    manufactureYearTo = json['manufactureYearTo'];
    isActive = json['isActive'];
    isReal = json['isReal'];
    cars = json['cars'];
    tariffValues = json['tariffValues'];
    carBasePrices = json['carBasePrices'];
    if (json['carTypeManufactureYears'] != null) {
      carTypeManufactureYears = <CarTypeManufactureYears>[];
      json['carTypeManufactureYears'].forEach((v) {
        carTypeManufactureYears!.add(new CarTypeManufactureYears.fromJson(v));
      });
    }
    if (json['carTypeColors'] != null) {
      carTypeColors = <CarTypeColors>[];
      json['carTypeColors'].forEach((v) {
        carTypeColors!.add(new CarTypeColors.fromJson(v));
      });
    }
    if (json['carTypeTrimColors'] != null) {
      carTypeTrimColors = <CarTypeTrimColors>[];
      json['carTypeTrimColors'].forEach((v) {
        carTypeTrimColors!.add(new CarTypeTrimColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['carModelId'] = this.carModelId;
    data['carModelDescription'] = this.carModelDescription;
    data['brandId'] = this.brandId;
    data['brandDescription'] = this.brandDescription;
    data['manufactureYearFrom'] = this.manufactureYearFrom;
    data['manufactureYearTo'] = this.manufactureYearTo;
    data['isActive'] = this.isActive;
    data['isReal'] = this.isReal;
    data['cars'] = this.cars;
    data['tariffValues'] = this.tariffValues;
    data['carBasePrices'] = this.carBasePrices;
    if (this.carTypeManufactureYears != null) {
      data['carTypeManufactureYears'] =
          this.carTypeManufactureYears!.map((v) => v.toJson()).toList();
    }
    if (this.carTypeColors != null) {
      data['carTypeColors'] =
          this.carTypeColors!.map((v) => v.toJson()).toList();
    }
    if (this.carTypeTrimColors != null) {
      data['carTypeTrimColors'] =
          this.carTypeTrimColors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarTypeManufactureYears {
  String? id;
  String? fromYear;
  String? toYear;
  String? carTypeId;
  String? carTypeDescription;
  String? manufactureYearId;
  String? miladiYear;
  String? persianYear;

  CarTypeManufactureYears(
      {this.id,
      this.fromYear,
      this.toYear,
      this.carTypeId,
      this.carTypeDescription,
      this.manufactureYearId,
      this.miladiYear,
      this.persianYear});

  CarTypeManufactureYears.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromYear = json['fromYear'];
    toYear = json['toYear'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    manufactureYearId = json['manufactureYearId'];
    miladiYear = json['miladiYear'];
    persianYear = json['persianYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromYear'] = this.fromYear;
    data['toYear'] = this.toYear;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['manufactureYearId'] = this.manufactureYearId;
    data['miladiYear'] = this.miladiYear;
    data['persianYear'] = this.persianYear;
    return data;
  }
}

class CarTypeColors {
  String? id;
  String? carTypeId;
  String? carTypeDescription;
  String? colorId;
  String? color;
  String? code;

  CarTypeColors(
      {this.id,
      this.carTypeId,
      this.carTypeDescription,
      this.colorId,
      this.color,
      this.code});

  CarTypeColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    colorId = json['colorId'];
    color = json['color'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['colorId'] = this.colorId;
    data['color'] = this.color;
    data['code'] = this.code;
    return data;
  }
}

class CarTypeTrimColors {
  String? id;
  String? carTypeId;
  String? carTypeDescription;
  String? colorId;
  String? color;

  CarTypeTrimColors(
      {this.id,
      this.carTypeId,
      this.carTypeDescription,
      this.colorId,
      this.color});

  CarTypeTrimColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    colorId = json['colorId'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['colorId'] = this.colorId;
    data['color'] = this.color;
    return data;
  }
}
