class SuggestionTypesResponse {
  int? status;
  String? message;
  String? count;
  List<SuggestionTypes>? suggestionTypes;

  SuggestionTypesResponse(
      {this.status, this.message, this.count, this.suggestionTypes});

  SuggestionTypesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['suggestionTypes'] != null) {
      suggestionTypes = <SuggestionTypes>[];
      json['suggestionTypes'].forEach((v) {
        suggestionTypes!.add(new SuggestionTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.suggestionTypes != null) {
      data['suggestionTypes'] =
          this.suggestionTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuggestionTypes {
  String? id;
  String? description;

  SuggestionTypes({this.id, this.description});

  SuggestionTypes.fromJson(Map<String, dynamic> json) {
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
