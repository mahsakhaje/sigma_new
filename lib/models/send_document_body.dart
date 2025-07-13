class SendDocumentBody {
  String? salesOrderId;
  List<Documents>? documents;
  String? token;

  SendDocumentBody({this.salesOrderId, this.documents, this.token});

  SendDocumentBody.fromJson(Map<String, dynamic> json) {
    salesOrderId = json['salesOrderId'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesOrderId'] = this.salesOrderId;
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    return data;
  }
}

class Documents {
  int? index;
  String? content;
  String? fileName;
  String? fileType;

  Documents({this.index, this.content, this.fileName, this.fileType});

  Documents.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    content = json['content'];
    fileName = json['fileName'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['content'] = this.content;
    data['fileName'] = this.fileName;
    data['fileType'] = this.fileType;
    return data;
  }
}
