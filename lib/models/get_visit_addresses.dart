class getVisitList {
  int? status;
  String? message;
  String? count;
  List<ExpertBranches>? expertBranches;

  getVisitList({this.status, this.message, this.count, this.expertBranches});

  getVisitList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['expertBranches'] != null) {
      expertBranches = <ExpertBranches>[];
      json['expertBranches'].forEach((v) {
        expertBranches!.add(new ExpertBranches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.expertBranches != null) {
      data['expertBranches'] =
          this.expertBranches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpertBranches {
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
  Null? children;
  Null? users;
  Null? document;

  ExpertBranches(
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
        this.children,
        this.users,
        this.document});

  ExpertBranches.fromJson(Map<String, dynamic> json) {
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
    data['children'] = this.children;
    data['users'] = this.users;
    data['document'] = this.document;
    return data;
  }
}
