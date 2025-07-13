class GetLoanPaymentResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<LoanPayments>? loanPayments;

  GetLoanPaymentResponse(
      {this.status,
        this.message,
        this.persianMessage,
        this.count,
        this.loanPayments});

  GetLoanPaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['loanPayments'] != null) {
      loanPayments = <LoanPayments>[];
      json['loanPayments'].forEach((v) {
        loanPayments!.add(new LoanPayments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.loanPayments != null) {
      data['loanPayments'] = this.loanPayments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoanPayments {
  String? id;
  String? description;
  String? amount;

  LoanPayments({this.id, this.description, this.amount});

  LoanPayments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['amount'] = this.amount;
    return data;
  }
}
