class FormsDetailResponse {
  int? status;
  String? message;
  SampleFile? sampleFile;

  FormsDetailResponse({this.status, this.message, this.sampleFile});

  FormsDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    sampleFile = json['sampleFile'] != null
        ? new SampleFile.fromJson(json['sampleFile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.sampleFile != null) {
      data['sampleFile'] = this.sampleFile!.toJson();
    }
    return data;
  }
}

class SampleFile {
  String? id;
  String? fileName;
  String? docId;
  String? typeId;
  String? typeDescription;
  String? isActive;
  Document? document;

  SampleFile(
      {this.id,
      this.fileName,
      this.docId,
      this.typeId,
      this.typeDescription,
      this.isActive,
      this.document});

  SampleFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['fileName'];
    docId = json['docId'];
    typeId = json['typeId'];
    typeDescription = json['typeDescription'];
    isActive = json['isActive'];
    document = json['document'] != null
        ? new Document.fromJson(json['document'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fileName'] = this.fileName;
    data['docId'] = this.docId;
    data['typeId'] = this.typeId;
    data['typeDescription'] = this.typeDescription;
    data['isActive'] = this.isActive;
    if (this.document != null) {
      data['document'] = this.document!.toJson();
    }
    return data;
  }
}

class Document {
  String? id;
  String? content;
  String? fileName;
  String? fileType;
  Null? documentType;

  Document(
      {this.id, this.content, this.fileName, this.fileType, this.documentType});

  Document.fromJson(Map<String, dynamic> json) {
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
