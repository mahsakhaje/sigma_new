class MainContentJsonModel {
  String? accountInfo;
  String? login;
  String? registeration;
  String? makeCar;
  String? styleCar;
  String? advanceSearch;
  String? brands;
  String? other;
  String? expertOrder;
  String? salesOrder;
  String? purchaseOrder;
  String? phone1;
  String? phone2;
  String? phone3;
  String? phone4;
  String? address;
  String? geoName;
  String? brand;
  String? manufactureYear;
  String? carModel;
  String? carType;
  String? price;
  String? bodyStyle;
  String? advanceSearchHead;
  String? advanceSearchText;
  String? roadsideAssistance;
  String? leasingServices;
  String? insuranceGuarantee;
  String? insurance;
  String? vipServices;
  String? recommendation;
  String? repaireCar;
  String? priceEstimation;
  String? carAssistance;
  String? exit;
  String? myProfile;
  String? todayTransaction;
  String? registerPurchaseOrder;
  String? repairShop;
  String? tuning;
  String? guaranty;
  String? guarantyOrder;
  String? commingSoon;
  String? categories;
  String? aboutUs;
  String? contactUs;

  MainContentJsonModel(
      {this.accountInfo,
        this.login,
        this.registeration,
        this.makeCar,
        this.styleCar,
        this.advanceSearch,
        this.brands,
        this.other,
        this.expertOrder,
        this.salesOrder,
        this.purchaseOrder,
        this.phone1,
        this.phone2,
        this.phone3,
        this.phone4,
        this.address,
        this.geoName,
        this.brand,
        this.manufactureYear,
        this.carModel,
        this.carType,
        this.price,
        this.bodyStyle,
        this.advanceSearchHead,
        this.advanceSearchText,
        this.roadsideAssistance,
        this.leasingServices,
        this.insuranceGuarantee,
        this.insurance,
        this.vipServices,
        this.recommendation,
        this.repaireCar,
        this.priceEstimation,
        this.carAssistance,
        this.exit,
        this.myProfile,
        this.todayTransaction,
        this.registerPurchaseOrder,
        this.repairShop,
        this.tuning,
        this.guaranty,
        this.guarantyOrder,
        this.commingSoon,
        this.categories,
        this.aboutUs,
        this.contactUs});

  MainContentJsonModel.fromJson(Map<String, dynamic> json) {
    accountInfo = json['accountInfo'];
    login = json['login'];
    registeration = json['registeration'];
    makeCar = json['makeCar'];
    styleCar = json['styleCar'];
    advanceSearch = json['advanceSearch'];
    brands = json['brands'];
    other = json['other'];
    expertOrder = json['expertOrder'];
    salesOrder = json['salesOrder'];
    purchaseOrder = json['purchaseOrder'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    phone3 = json['phone3'];
    phone4 = json['phone4'];
    address = json['address'];
    geoName = json['geoName'];
    brand = json['brand'];
    manufactureYear = json['manufactureYear'];
    carModel = json['carModel'];
    carType = json['carType'];
    price = json['price'];
    bodyStyle = json['bodyStyle'];
    advanceSearchHead = json['advanceSearchHead'];
    advanceSearchText = json['advanceSearchText'];
    roadsideAssistance = json['roadsideAssistance'];
    leasingServices = json['leasingServices'];
    insuranceGuarantee = json['insuranceGuarantee'];
    insurance = json['insurance'];
    vipServices = json['vipServices'];
    recommendation = json['recommendation'];
    repaireCar = json['repaireCar'];
    priceEstimation = json['priceEstimation'];
    carAssistance = json['carAssistance'];
    exit = json['exit'];
    myProfile = json['myProfile'];
    todayTransaction = json['todayTransaction'];
    registerPurchaseOrder = json['registerPurchaseOrder'];
    repairShop = json['repairShop'];
    tuning = json['tuning'];
    guaranty = json['guaranty'];
    guarantyOrder = json['guarantyOrder'];
    commingSoon = json['commingSoon'];
    categories = json['categories'];
    aboutUs = json['aboutUs'];
    contactUs = json['contactUs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountInfo'] = this.accountInfo;
    data['login'] = this.login;
    data['registeration'] = this.registeration;
    data['makeCar'] = this.makeCar;
    data['styleCar'] = this.styleCar;
    data['advanceSearch'] = this.advanceSearch;
    data['brands'] = this.brands;
    data['other'] = this.other;
    data['expertOrder'] = this.expertOrder;
    data['salesOrder'] = this.salesOrder;
    data['purchaseOrder'] = this.purchaseOrder;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['phone3'] = this.phone3;
    data['phone4'] = this.phone4;
    data['address'] = this.address;
    data['geoName'] = this.geoName;
    data['brand'] = this.brand;
    data['manufactureYear'] = this.manufactureYear;
    data['carModel'] = this.carModel;
    data['carType'] = this.carType;
    data['price'] = this.price;
    data['bodyStyle'] = this.bodyStyle;
    data['advanceSearchHead'] = this.advanceSearchHead;
    data['advanceSearchText'] = this.advanceSearchText;
    data['roadsideAssistance'] = this.roadsideAssistance;
    data['leasingServices'] = this.leasingServices;
    data['insuranceGuarantee'] = this.insuranceGuarantee;
    data['insurance'] = this.insurance;
    data['vipServices'] = this.vipServices;
    data['recommendation'] = this.recommendation;
    data['repaireCar'] = this.repaireCar;
    data['priceEstimation'] = this.priceEstimation;
    data['carAssistance'] = this.carAssistance;
    data['exit'] = this.exit;
    data['myProfile'] = this.myProfile;
    data['todayTransaction'] = this.todayTransaction;
    data['registerPurchaseOrder'] = this.registerPurchaseOrder;
    data['repairShop'] = this.repairShop;
    data['tuning'] = this.tuning;
    data['guaranty'] = this.guaranty;
    data['guarantyOrder'] = this.guarantyOrder;
    data['commingSoon'] = this.commingSoon;
    data['categories'] = this.categories;
    data['aboutUs'] = this.aboutUs;
    data['contactUs'] = this.contactUs;
    return data;
  }
}
