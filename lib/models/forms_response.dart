class FormsResponse {
  int? status;
  String? message;
  String? count;
  List<SampleFiles>? sampleFiles;

  FormsResponse({this.status, this.message, this.count, this.sampleFiles});

  FormsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['sampleFiles'] != null) {
      sampleFiles = <SampleFiles>[];
      json['sampleFiles'].forEach((v) {
        sampleFiles!.add(new SampleFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.sampleFiles != null) {
      data['sampleFiles'] = this.sampleFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SampleFiles {
  String? id;
  String? fileName;
  String? docId;
  String? typeId;
  String? typeDescription;
  String? isActive;

  SampleFiles({
    this.id,
    this.fileName,
    this.docId,
    this.typeId,
    this.typeDescription,
    this.isActive,
  });

  SampleFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['fileName'];
    docId = json['docId'];
    typeId = json['typeId'];
    typeDescription = json['typeDescription'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fileName'] = this.fileName;
    data['docId'] = this.docId;
    data['typeId'] = this.typeId;
    data['typeDescription'] = this.typeDescription;
    data['isActive'] = this.isActive;
    return data;
  }
}
