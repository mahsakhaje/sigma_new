class RulesResponse {
  int? status;
  String? message;
  ManaRule? manaRule;

  RulesResponse({this.status, this.message, this.manaRule});

  RulesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    manaRule = json['manaRule'] != null
        ? new ManaRule.fromJson(json['manaRule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.manaRule != null) {
      data['manaRule'] = this.manaRule!.toJson();
    }
    return data;
  }
}

class ManaRule {
  String? id;
  String? description;
  String? type;
  String? isActive;

  ManaRule({this.id, this.description, this.type, this.isActive});

  ManaRule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    type = json['type'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['type'] = this.type;
    data['isActive'] = this.isActive;
    return data;
  }
}
