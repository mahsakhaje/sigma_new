class UpdateResponse {
  int? status;
  String? message;
  String? forceUpdate;
  String? minVersion;
  String? newVersion;
  String? updateLink;

  UpdateResponse(
      {this.status,
      this.message,
      this.forceUpdate,
      this.minVersion,
      this.newVersion,
      this.updateLink});

  UpdateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    updateLink = json['updateLink'];
    newVersion = json['newVersion'];
    minVersion = json['minVersion'];
    forceUpdate = json['forceUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
