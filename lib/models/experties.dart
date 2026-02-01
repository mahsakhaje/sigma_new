class ExpertiseResponse {
  final int status;
  final String message;
  final String persianMessage;
  final String itemTypes1;
  final String itemTypes2;
  final String itemTypes3;
  final String itemTypes4;
  final String itemTypes5;
  final String itemTypes6;
  final String type1IsOk;
  final String type2IsOk;
  final String type3IsOk;
  final String type4IsOk;
  final String type5IsOk;
  final String type6IsOk;

  ExpertiseResponse({
    required this.status,
    required this.message,
    required this.persianMessage,
    required this.itemTypes1,
    required this.itemTypes2,
    required this.itemTypes3,
    required this.itemTypes4,
    required this.itemTypes5,
    required this.itemTypes6,
    required this.type1IsOk,
    required this.type2IsOk,
    required this.type3IsOk,
    required this.type4IsOk,
    required this.type5IsOk,
    required this.type6IsOk,
  });

  factory ExpertiseResponse.fromJson(Map<String, dynamic> json) {
    return ExpertiseResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      persianMessage: json['persianMessage'] ?? '',
      itemTypes1: json['itemTypes1'] ?? '',
      itemTypes2: json['itemTypes2'] ?? '',
      itemTypes3: json['itemTypes3'] ?? '',
      itemTypes4: json['itemTypes4'] ?? '',
      itemTypes5: json['itemTypes5'] ?? '',
      itemTypes6: json['itemTypes6'] ?? '',
      type1IsOk: json['type1IsOk'] ?? '0',
      type2IsOk: json['type2IsOk'] ?? '0',
      type3IsOk: json['type3IsOk'] ?? '0',
      type4IsOk: json['type4IsOk'] ?? '0',
      type5IsOk: json['type5IsOk'] ?? '0',
      type6IsOk: json['type6IsOk'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'persianMessage': persianMessage,
      'itemTypes1': itemTypes1,
      'itemTypes2': itemTypes2,
      'itemTypes3': itemTypes3,
      'itemTypes4': itemTypes4,
      'itemTypes5': itemTypes5,
      'itemTypes6': itemTypes6,
      'type1IsOk': type1IsOk,
      'type2IsOk': type2IsOk,
      'type3IsOk': type3IsOk,
      'type4IsOk': type4IsOk,
      'type5IsOk': type5IsOk,
      'type6IsOk': type6IsOk,
    };
  }
}