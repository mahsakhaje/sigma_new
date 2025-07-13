import 'package:sigma/models/sigma_rales_response_model.dart';

class TransactionsResponse {
  int? status;
  String? message;
  String? count;
  List<SalesOrders>? salesOrders;

  TransactionsResponse(
      {this.status, this.message, this.count, this.salesOrders});

  TransactionsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['salesOrders'] != null) {
      salesOrders = <SalesOrders>[];
      json['salesOrders'].forEach((v) {
        salesOrders!.add(new SalesOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.salesOrders != null) {
      data['salesOrders'] = this.salesOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


