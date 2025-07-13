class TrackingSalesOrderResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? step;
  String? orderNumber;
  String? registerDate;
  String? timespanDate;
  String? timespanTime;
  String? showRoomName;
  String? showRoomAddress;
  String? accountManagerName;
  String? expertOrderId;
  String? expertDate;
  String? expertUser;
  String? expertPriceDate;
  String? expertPriceAmount;
  String? advertiseAmount;
  String? advertiseDate;
  String? advertiseTime;
  String? contractDate;
  String? contractTime;
  String? contractAmount;
  String? contractParkingName;
  String? contractParkingAddress;
  String? contractNumber;
  String? contractConfirmDate;
  String? contractConfirmTime;

  TrackingSalesOrderResponse(
      {this.status,
      this.message,
      this.persianMessage,
      this.step,
      this.orderNumber,
      this.registerDate,
      this.timespanDate,
      this.timespanTime,
      this.showRoomName,
      this.showRoomAddress,
      this.accountManagerName,
      this.expertOrderId,
      this.expertDate,
      this.expertUser,
      this.expertPriceDate,
      this.expertPriceAmount,
      this.advertiseAmount,
      this.advertiseDate,
      this.advertiseTime,
      this.contractDate,
      this.contractTime,
      this.contractAmount,
      this.contractParkingName,
      this.contractParkingAddress,
      this.contractNumber,
      this.contractConfirmDate,
      this.contractConfirmTime});

  TrackingSalesOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    step = json['step'];
    orderNumber = json['orderNumber'];
    registerDate = json['registerDate'];
    timespanDate = json['timespanDate'];
    timespanTime = json['timespanTime'];
    showRoomName = json['showRoomName'];
    showRoomAddress = json['showRoomAddress'];
    accountManagerName = json['accountManagerName'];
    expertOrderId = json['expertOrderId'];
    expertDate = json['expertDate'];
    expertUser = json['expertUser'];
    expertPriceDate = json['expertPriceDate'];
    expertPriceAmount = json['expertPriceAmount'];
    advertiseAmount = json['advertiseAmount'];
    advertiseDate = json['advertiseDate'];
    advertiseTime = json['advertiseTime'];
    contractDate = json['contractDate'];
    contractTime = json['contractTime'];
    contractAmount = json['contractAmount'];
    contractParkingName = json['contractParkingName'];
    contractParkingAddress = json['contractParkingAddress'];
    contractNumber = json['contractNumber'];
    contractConfirmDate = json['contractConfirmDate'];
    contractConfirmTime = json['contractConfirmTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['step'] = this.step;
    data['orderNumber'] = this.orderNumber;
    data['registerDate'] = this.registerDate;
    data['timespanDate'] = this.timespanDate;
    data['timespanTime'] = this.timespanTime;
    data['showRoomName'] = this.showRoomName;
    data['showRoomAddress'] = this.showRoomAddress;
    data['accountManagerName'] = this.accountManagerName;
    data['expertOrderId'] = this.expertOrderId;
    data['expertDate'] = this.expertDate;
    data['expertUser'] = this.expertUser;
    data['expertPriceDate'] = this.expertPriceDate;
    data['expertPriceAmount'] = this.expertPriceAmount;
    data['advertiseAmount'] = this.advertiseAmount;
    data['advertiseDate'] = this.advertiseDate;
    data['advertiseTime'] = this.advertiseTime;
    data['contractDate'] = this.contractDate;
    data['contractTime'] = this.contractTime;
    data['contractAmount'] = this.contractAmount;
    data['contractParkingName'] = this.contractParkingName;
    data['contractParkingAddress'] = this.contractParkingAddress;
    data['contractNumber'] = this.contractNumber;
    data['contractConfirmDate'] = this.contractConfirmDate;
    data['contractConfirmTime'] = this.contractConfirmTime;
    return data;
  }
}
