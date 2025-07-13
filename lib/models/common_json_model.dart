class CommonJsonModel {
  String? expertOrder;
  String? salesOrder;
  String? purchaseOrder;
  String? search;
  String? required;
  String? username;
  String? password;
  String? register;
  String? registration;
  String? login;
  String? resetPass;
  String? submit;
  String? kilooMeter;
  String? cancel;
  String? yes;
  String? no;
  String? toman;
  String? home;
  String? back;
  String? invalidUserNameOrPassword;
  String? invalidPhoneNumber;
  String? edit;
  String? addedSuccessfully;
  String? incorrectMileage;
  String? km;
  String? continue1;
  String? next;

  CommonJsonModel(
      {this.expertOrder,
      this.salesOrder,
      this.purchaseOrder,
      this.search,
      this.required,
      this.username,
      this.password,
      this.register,
      this.registration,
      this.login,
      this.resetPass,
      this.submit,
      this.kilooMeter,
      this.cancel,
      this.yes,
      this.no,
      this.toman,
      this.home,
      this.back,
      this.invalidUserNameOrPassword,
      this.invalidPhoneNumber,
      this.edit,
      this.addedSuccessfully,
      this.incorrectMileage,
      this.km,
      this.continue1,
      this.next});

  CommonJsonModel.fromJson(Map<String, dynamic> json) {
    expertOrder = json['expertOrder'];
    salesOrder = json['salesOrder'];
    purchaseOrder = json['purchaseOrder'];
    search = json['search'];
    required = json['required'];
    username = json['username'];
    password = json['password'];
    register = json['register'];
    registration = json['registration'];
    login = json['login'];
    resetPass = json['resetPass'];
    submit = json['submit'];
    kilooMeter = json['kilooMeter'];
    cancel = json['cancel'];
    yes = json['yes'];
    no = json['no'];
    toman = json['toman'];
    home = json['home'];
    back = json['back'];
    invalidUserNameOrPassword = json['invalidUserNameOrPassword'];
    invalidPhoneNumber = json['invalidPhoneNumber'];
    edit = json['edit'];
    addedSuccessfully = json['addedSuccessfully'];
    incorrectMileage = json['incorrectMileage'];
    km = json['km'];
    continue1 = json['continue'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expertOrder'] = this.expertOrder;
    data['salesOrder'] = this.salesOrder;
    data['purchaseOrder'] = this.purchaseOrder;
    data['search'] = this.search;
    data['required'] = this.required;
    data['username'] = this.username;
    data['password'] = this.password;
    data['register'] = this.register;
    data['registration'] = this.registration;
    data['login'] = this.login;
    data['resetPass'] = this.resetPass;
    data['submit'] = this.submit;
    data['kilooMeter'] = this.kilooMeter;
    data['cancel'] = this.cancel;
    data['yes'] = this.yes;
    data['no'] = this.no;
    data['toman'] = this.toman;
    data['home'] = this.home;
    data['back'] = this.back;
    data['invalidUserNameOrPassword'] = this.invalidUserNameOrPassword;
    data['invalidPhoneNumber'] = this.invalidPhoneNumber;
    data['edit'] = this.edit;
    data['addedSuccessfully'] = this.addedSuccessfully;
    data['incorrectMileage'] = this.incorrectMileage;
    data['km'] = this.km;
    data['continue'] = this.continue1;
    data['next'] = this.next;
    return data;
  }
}
