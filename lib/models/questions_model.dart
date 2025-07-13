class QuestionsResponse {
  int? status;
  String? message;
  String? count;
  List<FaqContents>? faqContents;
  String? title;

  QuestionsResponse(
      {this.status, this.message, this.count, this.faqContents, this.title});

  QuestionsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['faqContents'] != null) {
      faqContents = <FaqContents>[];
      json['faqContents'].forEach((v) {
        faqContents!.add(new FaqContents.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.faqContents != null) {
      data['faqContents'] = this.faqContents!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    return data;
  }
}

class FaqContents {
  String? id;
  String? question;
  String? response;
  String? faqTitleId;
  String? faqTitleDescription;
  String? isActive;

  FaqContents(
      {this.id,
      this.question,
      this.response,
      this.faqTitleId,
      this.faqTitleDescription,
      this.isActive});

  FaqContents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    response = json['response'];
    faqTitleId = json['faqTitleId'];
    faqTitleDescription = json['faqTitleDescription'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['response'] = this.response;
    data['faqTitleId'] = this.faqTitleId;
    data['faqTitleDescription'] = this.faqTitleDescription;
    data['isActive'] = this.isActive;
    return data;
  }
}
