class PublishedTransactionsResponse {
  int? status;
  String? message;
  String? count;
  List<Transactions>? transactions;

  PublishedTransactionsResponse(
      {this.status, this.message, this.count, this.transactions});

  PublishedTransactionsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? id;
  String? description;
  String? transactionDate;
  String? type;
  String? typeText;
  String? brandId;
  String? brandDescription;
  String? carModelId;
  String? carModelDescription;
  String? carTypeId;
  String? carTypeDescription;
  String? colorId;
  String? colorDescription;
  String? trimColorId;
  String? trimColorDescription;
  String? manufactureYearId;
  String? persianYear;
  String? miladiYear;
  String? published;
  List<Documents>? documents;

  Transactions(
      {this.id,
        this.description,
        this.transactionDate,
        this.type,
        this.typeText,
        this.brandId,
        this.brandDescription,
        this.carModelId,
        this.carModelDescription,
        this.carTypeId,
        this.carTypeDescription,
        this.colorId,
        this.colorDescription,
        this.trimColorId,
        this.trimColorDescription,
        this.manufactureYearId,
        this.persianYear,
        this.miladiYear,
        this.published,
        this.documents});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    transactionDate = json['transactionDate'];
    type = json['type'];
    typeText = json['typeText'];
    brandId = json['brandId'];
    brandDescription = json['brandDescription'];
    carModelId = json['carModelId'];
    carModelDescription = json['carModelDescription'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    colorId = json['colorId'];
    colorDescription = json['colorDescription'];
    trimColorId = json['trimColorId'];
    trimColorDescription = json['trimColorDescription'];
    manufactureYearId = json['manufactureYearId'];
    persianYear = json['persianYear'];
    miladiYear = json['miladiYear'];
    published = json['published'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['transactionDate'] = this.transactionDate;
    data['type'] = this.type;
    data['typeText'] = this.typeText;
    data['brandId'] = this.brandId;
    data['brandDescription'] = this.brandDescription;
    data['carModelId'] = this.carModelId;
    data['carModelDescription'] = this.carModelDescription;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['colorId'] = this.colorId;
    data['colorDescription'] = this.colorDescription;
    data['trimColorId'] = this.trimColorId;
    data['trimColorDescription'] = this.trimColorDescription;
    data['manufactureYearId'] = this.manufactureYearId;
    data['persianYear'] = this.persianYear;
    data['miladiYear'] = this.miladiYear;
    data['published'] = this.published;
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
  String? documentType;

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
