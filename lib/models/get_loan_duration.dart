class GetLoanDurationResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  String? infoLink;
  List<LoanDurations>? loanDurations;

  GetLoanDurationResponse(
      {this.status,
        this.message,
        this.persianMessage,
        this.count,
        this.loanDurations});

  GetLoanDurationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    infoLink = json['infoLink'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['loanDurations'] != null) {
      loanDurations = <LoanDurations>[];
      json['loanDurations'].forEach((v) {
        loanDurations!.add(new LoanDurations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['infoLink'] = this.infoLink;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.loanDurations != null) {
      data['loanDurations'] =
          this.loanDurations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoanDurations {
  String? id;
  String? description;

  LoanDurations({this.id, this.description});

  LoanDurations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}
