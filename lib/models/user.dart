class User {
  bool? result;
  String? msg;

  User({this.result, this.msg});

  User.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['msg'] = msg;
    return data;
  }
}
