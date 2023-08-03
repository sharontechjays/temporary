

import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';
@JsonSerializable()
/*class LoginModel {
  LoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
  });

  late final int id;
  late final String username;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String gender;
  late final String image;
  late final String token;

  *//*LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['image'] = image;
    data['token'] = token;
    return data;
  }*//*
  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}*/

@JsonSerializable(explicitToJson: true)
class LoginModel {
  @JsonKey(required: true)
  final int id;

  @JsonKey(required: true)
  final String username;

  @JsonKey(required: true)
  final String email;

  @JsonKey(required: true)
  final String firstName;

  @JsonKey(required: true)
  final String lastName;

  @JsonKey(required: true)
  final String gender;

  @JsonKey(required: true)
  final String image;

  @JsonKey(required: true)
  final String token;

  LoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
  });

  // Factory constructor to parse JSON to LoginModel
  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  // Factory constructor to convert LoginModel to JSON
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

