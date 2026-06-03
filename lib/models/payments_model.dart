class PaymentsResponse {
  int? status;
  String? message;
  String? persianMessage;
  List<Payment>? payments; // اضافه شدن لیست Payment

  PaymentsResponse({this.status, this.message, this.persianMessage, this.payments});

  PaymentsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];

    // پارس کردن لیست پرداخت‌ها از JSON
    if (json['credits'] != null) {
      payments = <Payment>[];
      json['credits'].forEach((v) {
        payments!.add(Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['persianMessage'] = persianMessage;

    // تبدیل لیست پرداخت‌ها به JSON
    if (payments != null) {
      data['credits'] = payments!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

// کلاس Payment اضافه شده
class Payment {
  String? registerDate;
  String? registerTime;
  String? amount;
  String? bankCardNumber;
  String? bankFactorNumber;
  String? bankStatus;

  Payment({
    this.registerDate,
    this.registerTime,
    this.amount,
    this.bankCardNumber,
    this.bankStatus,
    this.bankFactorNumber,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    registerDate = json['registerDate'];
    registerTime = json['registerTime'];
    bankStatus = json['bankStatus'];
    amount = json['amount'];
    bankCardNumber = json['bankCardNumber'];
    bankFactorNumber = json['bankFactorNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registerDate'] = registerDate;
    data['registerTime'] = registerTime;
    data['amount'] = amount;
    data['bankStatus'] = bankStatus;
    data['bankCardNumber'] = bankCardNumber;
    data['bankFactorNumber'] = bankFactorNumber;
    return data;
  }
}
