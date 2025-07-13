class AllCitiesResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<GeoNames>? geoNames;

  AllCitiesResponse(
      {this.status,
        this.message,
        this.persianMessage,
        this.count,
        this.geoNames});

  AllCitiesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['geoNames'] != null) {
      geoNames = <GeoNames>[];
      json['geoNames'].forEach((v) {
        geoNames!.add(new GeoNames.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.geoNames != null) {
      data['geoNames'] = this.geoNames!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeoNames {
  String? id;
  String? description;
  String? type;
  String? lat;
  String? lon;
  String? parentId;
  String? isActive;

  GeoNames(
      {this.id,
        this.description,
        this.type,
        this.lat,
        this.lon,
        this.parentId,
        this.isActive});

  GeoNames.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    type = json['type'];
    lat = json['lat'];
    lon = json['lon'];
    parentId = json['parentId'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['type'] = this.type;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['parentId'] = this.parentId;
    data['isActive'] = this.isActive;
    return data;
  }
}
