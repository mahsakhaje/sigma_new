class UpdateInsertOrderResponse {
  int? status;
  String? message;
  Null? salesOrder;
  List<Documents>? documents;

  UpdateInsertOrderResponse(
      {this.status, this.message, this.salesOrder, this.documents});

  UpdateInsertOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    salesOrder = json['salesOrder'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['salesOrder'] = this.salesOrder;
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  String? id;
  String? content;
  String? fileName;
  String? fileType;
  Null? documentType;

  Documents(
      {this.id, this.content, this.fileName, this.fileType, this.documentType});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    fileName = json['fileName'];
    fileType = json['fileType'];
    documentType = json['documentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['fileName'] = this.fileName;
    data['fileType'] = this.fileType;
    data['documentType'] = this.documentType;
    return data;
  }
}
