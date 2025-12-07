class AccountAnnouncmentModel {
  int? status;
  String? message;
  String? all;
  String? announcementStatus;
  String? carModelIds;

  AccountAnnouncmentModel({this.status, this.message, this.all,this.announcementStatus,this.carModelIds});

  AccountAnnouncmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    all = json['all'];
    announcementStatus = json['announcementStatus'];
    carModelIds = json['carModelIds'];


  }

}


