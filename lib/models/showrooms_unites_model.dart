class ShowroomsUniteResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<Units>? units;

  ShowroomsUniteResponse(
      {this.status, this.message, this.persianMessage, this.count, this.units});

  ShowroomsUniteResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.units != null) {
      data['units'] = this.units!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Units {
  String? id;
  String? name;
  String? code;
  String? lat;
  String? lon;
  String? address;
  String? parentCode;
  String? parentId;
  String? parentName;
  String? isActive;
  String? sale;
  String? maintenance;
  String? isShowRoom;
  String? isParking;
  String? parkingAmount;
  String? geoNameId;
  String? geoNameDescription;
  String? provinceId;
  String? provinceDescription;
  String? googleMapLink;
  String? salesOrderNumber;
  String? telNumber;
  String? children;
  String? users;
  String? document;

  Units(
      {this.id,
        this.name,
        this.code,
        this.lat,
        this.lon,
        this.address,
        this.parentCode,
        this.parentId,
        this.parentName,
        this.isActive,
        this.sale,
        this.maintenance,
        this.isShowRoom,
        this.isParking,
        this.parkingAmount,
        this.geoNameId,
        this.geoNameDescription,
        this.provinceId,
        this.provinceDescription,
        this.googleMapLink,
        this.salesOrderNumber,
        this.telNumber,
        this.children,
        this.users,
        this.document});

  Units.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    lat = json['lat'];
    lon = json['lon'];
    address = json['address'];
    parentCode = json['parentCode'];
    parentId = json['parentId'];
    parentName = json['parentName'];
    isActive = json['isActive'];
    sale = json['sale'];
    maintenance = json['maintenance'];
    isShowRoom = json['isShowRoom'];
    isParking = json['isParking'];
    parkingAmount = json['parkingAmount'];
    geoNameId = json['geoNameId'];
    geoNameDescription = json['geoNameDescription'];
    provinceId = json['provinceId'];
    provinceDescription = json['provinceDescription'];
    googleMapLink = json['googleMapLink'];
    salesOrderNumber = json['salesOrderNumber'];
    telNumber = json['telNumber'];
    children = json['children'];
    users = json['users'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['address'] = this.address;
    data['parentCode'] = this.parentCode;
    data['parentId'] = this.parentId;
    data['parentName'] = this.parentName;
    data['isActive'] = this.isActive;
    data['sale'] = this.sale;
    data['maintenance'] = this.maintenance;
    data['isShowRoom'] = this.isShowRoom;
    data['isParking'] = this.isParking;
    data['parkingAmount'] = this.parkingAmount;
    data['geoNameId'] = this.geoNameId;
    data['geoNameDescription'] = this.geoNameDescription;
    data['provinceId'] = this.provinceId;
    data['provinceDescription'] = this.provinceDescription;
    data['googleMapLink'] = this.googleMapLink;
    data['salesOrderNumber'] = this.salesOrderNumber;
    data['telNumber'] = this.telNumber;
    data['children'] = this.children;
    data['users'] = this.users;
    data['document'] = this.document;
    return data;
  }
}
