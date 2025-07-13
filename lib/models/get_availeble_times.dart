class GetAvailebleTimeResponse {
  int? status;
  String? message;
  String? count;
  List<Timespans>? timespans;

  GetAvailebleTimeResponse(
      {this.status, this.message, this.count, this.timespans});

  GetAvailebleTimeResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['timespans'] != null) {
      timespans = <Timespans>[];
      json['timespans'].forEach((v) {
        if (v != null) {
          timespans!.add(new Timespans.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.timespans != null) {
      data['timespans'] = this.timespans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timespans {
  String? id;
  String? description;
  String? date;
  String? dayOfWeek;
  String? isHoliday;
  String? isActive;
  List<Times>? times;

  Timespans(
      {this.id,
      this.description,
      this.date,
      this.dayOfWeek,
      this.isHoliday,
      this.isActive,
      this.times});

  Timespans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    date = json['date'];
    dayOfWeek = json['dayOfWeek'];
    isHoliday = json['isHoliday'];
    isActive = json['isActive'];
    if (json['times'] != null) {
      times = <Times>[];
      json['times'].forEach((v) {
        times!.add(new Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['date'] = this.date;
    data['dayOfWeek'] = this.dayOfWeek;
    data['isHoliday'] = this.isHoliday;
    data['isActive'] = this.isActive;
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Times {
  String? id;
  String? description;
  List<AccountManagers>? accountManagers;

  Times({this.id, this.description, this.accountManagers});

  Times.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    if (json['accountManagers'] != null) {
      accountManagers = <AccountManagers>[];
      json['accountManagers'].forEach((v) {
        accountManagers!.add(new AccountManagers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    if (this.accountManagers != null) {
      data['accountManagers'] =
          this.accountManagers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountManagers {
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
  bool? validForUpdate;
  bool? validMarketer;

  AccountManagers(
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
      this.validForUpdate,
      this.validMarketer});

  AccountManagers.fromJson(Map<String, dynamic> json) {
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
    validForUpdate = json['validForUpdate'];
    validMarketer = json['validMarketer'];
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
    data['validForUpdate'] = this.validForUpdate;
    data['validMarketer'] = this.validMarketer;
    return data;
  }
}
