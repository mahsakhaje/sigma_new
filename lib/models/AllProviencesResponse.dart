import 'package:sigma/models/AllCitiesResponse.dart';

class AllProvincesResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<GeoNames>? geoNames;


  AllProvincesResponse(
      {this.status,
      this.message,
      this.persianMessage,
      this.count,
      this.geoNames});

  AllProvincesResponse.fromJson(Map<String, dynamic> json) {
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

