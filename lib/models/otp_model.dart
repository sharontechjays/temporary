class OtpModel {
  bool? result;
  String? msg;
  Data? data;

  OtpModel({this.result, this.msg, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? token;
  String? mobileNumber;
  bool? isPinAvailable;
  String? firstName;
  String? lastName;

  Data(
      {this.userId,
      this.token,
      this.mobileNumber,
      this.isPinAvailable,
      this.firstName,
      this.lastName});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    token = json['token'];
    mobileNumber = json['mobile_number'];
    isPinAvailable = json['is_pin_available'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['token'] = token;
    data['mobile_number'] = mobileNumber;
    data['is_pin_available'] = isPinAvailable;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
