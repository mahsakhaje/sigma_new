class UserInfoResponse {
  int? status;
  String? message;
  String? persianMessage;
  Account? account;

  UserInfoResponse(
      {this.status, this.message, this.persianMessage, this.account});

  UserInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}

class Account {
  String? id;
  String? isReal;
  String? nationalId;
  String? cellNumber;
  String? password;
  String? name;
  String? email;
  String? sex;
  String? lastName;
  String? balance;
  String? orgName;
  String? orgNationalId;
  String? accountType;
  String? refCode;
  String? refLink;
  String? accountTypeText;
  String? postalCode;
  String? accountAddress;
  String? captcha;
  String? realCaptcha;
  String? hiddenCaptcha;
  String? referralChannel;
  String? referralCode;
  String? registerDate;
  String? fromDate;
  String? toDate;
  String? geoNameId;
  String? geoNameDescription;
  String? provinceId;
  String? provinceDescription;

  Account(
      {this.id,
      this.isReal,
      this.nationalId,
      this.cellNumber,
      this.password,
      this.name,
      this.email,
      this.lastName,
      this.balance,
      this.orgName,
      this.refCode,
      this.sex,
      this.refLink,
      this.orgNationalId,
      this.accountType,
      this.accountTypeText,
      this.postalCode,
      this.accountAddress,
      this.captcha,
      this.realCaptcha,
      this.hiddenCaptcha,
      this.referralChannel,
      this.referralCode,
      this.registerDate,
      this.fromDate,
      this.toDate,
      this.geoNameId,
      this.geoNameDescription,
      this.provinceId,
      this.provinceDescription});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isReal = json['isReal'];
    nationalId = json['nationalId'];
    cellNumber = json['cellNumber'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
    refCode = json['refCode'];
    refLink = json['refLink'];
    sex = json['sex'];
    lastName = json['lastName'];
    balance = json['balance'];
    orgName = json['orgName'];
    orgNationalId = json['orgNationalId'];
    accountType = json['accountType'];
    accountTypeText = json['accountTypeText'];
    postalCode = json['postalCode'];
    accountAddress = json['accountAddress'];
    captcha = json['captcha'];
    realCaptcha = json['realCaptcha'];
    hiddenCaptcha = json['hiddenCaptcha'];
    referralChannel = json['referralChannel'];
    referralCode = json['referralCode'];
    registerDate = json['registerDate'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    geoNameId = json['geoNameId'];
    geoNameDescription = json['geoNameDescription'];
    provinceId = json['provinceId'];
    provinceDescription = json['provinceDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isReal'] = this.isReal;
    data['nationalId'] = this.nationalId;
    data['cellNumber'] = this.cellNumber;
    data['password'] = this.password;
    data['name'] = this.name;
    data['sex'] = this.sex;
    data['email'] = this.email;
    data['lastName'] = this.lastName;
    data['balance'] = this.balance;
    data['orgName'] = this.orgName;
    data['orgNationalId'] = this.orgNationalId;
    data['accountType'] = this.accountType;
    data['accountTypeText'] = this.accountTypeText;
    data['postalCode'] = this.postalCode;
    data['accountAddress'] = this.accountAddress;
    data['captcha'] = this.captcha;
    data['realCaptcha'] = this.realCaptcha;
    data['hiddenCaptcha'] = this.hiddenCaptcha;
    data['referralChannel'] = this.referralChannel;
    data['referralCode'] = this.referralCode;
    data['registerDate'] = this.registerDate;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['geoNameId'] = this.geoNameId;
    data['geoNameDescription'] = this.geoNameDescription;
    data['provinceId'] = this.provinceId;
    data['provinceDescription'] = this.provinceDescription;
    return data;
  }
}
