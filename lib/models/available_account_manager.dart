class AvailableAccountManagersResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<Users>? users;

  AvailableAccountManagersResponse(
      {this.status, this.message, this.persianMessage, this.count, this.users});

  AvailableAccountManagersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? id;
  String? username;
  String? password;
  String? role;
  String? permission;
  String? name;
  String? lastname;
  String? cellNumber;
  String? email;
  String? prefix;
  String? isActive;
  String? unitId;
  String? unitCode;
  String? unitName;
  String? isMarketer;
  String? logo;
  String? expertOrders;
  bool? validMarketer;
  bool? validForUpdate;

  Users(
      {this.id,
        this.username,
        this.password,
        this.role,
        this.permission,
        this.name,
        this.lastname,
        this.cellNumber,
        this.email,
        this.prefix,
        this.isActive,
        this.unitId,
        this.unitCode,
        this.unitName,
        this.isMarketer,
        this.logo,
        this.expertOrders,
        this.validMarketer,
        this.validForUpdate});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    role = json['role'];
    permission = json['permission'];
    name = json['name'];
    lastname = json['lastname'];
    cellNumber = json['cellNumber'];
    email = json['email'];
    prefix = json['prefix'];
    isActive = json['isActive'];
    unitId = json['unitId'];
    unitCode = json['unitCode'];
    unitName = json['unitName'];
    isMarketer = json['isMarketer'];
    logo = json['logo'];
    expertOrders = json['expertOrders'];
    validMarketer = json['validMarketer'];
    validForUpdate = json['validForUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['role'] = this.role;
    data['permission'] = this.permission;
    data['name'] = this.name;
    data['lastname'] = this.lastname;
    data['cellNumber'] = this.cellNumber;
    data['email'] = this.email;
    data['prefix'] = this.prefix;
    data['isActive'] = this.isActive;
    data['unitId'] = this.unitId;
    data['unitCode'] = this.unitCode;
    data['unitName'] = this.unitName;
    data['isMarketer'] = this.isMarketer;
    data['logo'] = this.logo;
    data['expertOrders'] = this.expertOrders;
    data['validMarketer'] = this.validMarketer;
    data['validForUpdate'] = this.validForUpdate;
    return data;
  }
}
