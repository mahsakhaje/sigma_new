class CarTypeEquipmentInfoResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<String?> equipments;

  CarTypeEquipmentInfoResponse(
      {required this.status,
      required this.message,
      required this.persianMessage,
      required this.count,
      required this.equipments});

  factory CarTypeEquipmentInfoResponse.fromJson(Map<String, dynamic> json) {
    return CarTypeEquipmentInfoResponse(
        status: json['status'],
        message: json['message'],
        persianMessage: json['persianMessage'],
        count: json['count'],
        equipments:json['equipments']==null?[]: json['equipments']?.cast<String?>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    data['equipments'] = this.equipments;
    return data;
  }
}
