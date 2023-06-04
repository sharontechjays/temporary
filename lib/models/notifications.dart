class Notifications {
  bool? result;
  String? msg;
  bool? nextLink;
  List<Data>? data;

  Notifications({this.result, this.msg, this.nextLink, this.data});

  Notifications.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    nextLink = json['next_link'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['msg'] = msg;
    data['next_link'] = nextLink;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? notificationId;
  String? title;
  String? message;
  NotificationData? notificationData;
  String? createdOn;
  SentByUser? sentByUser;
  bool? isRead;
  String? notificationType;

  Data(
      {this.notificationId,
      this.title,
      this.message,
      this.notificationData,
      this.createdOn,
      this.sentByUser,
      this.isRead,
      this.notificationType});

  Data.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    title = json['title'];
    message = json['message'];
    notificationData = json['notification_data'] != null
        ? NotificationData.fromJson(json['notification_data'])
        : null;
    createdOn = json['created_on'];
    sentByUser = json['sent_by_user'] != null
        ? SentByUser.fromJson(json['sent_by_user'])
        : null;
    isRead = json['is_read'];
    notificationType = json['notification_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_id'] = notificationId;
    data['title'] = title;
    data['message'] = message;
    if (notificationData != null) {
      data['notification_data'] = notificationData!.toJson();
    }
    data['created_on'] = createdOn;
    if (sentByUser != null) {
      data['sent_by_user'] = sentByUser!.toJson();
    }
    data['is_read'] = isRead;
    data['notification_type'] = notificationType;
    return data;
  }
}

class NotificationData {
  String? countryCode;
  int? sentByUser;
  String? mobileNumber;
  int? notificationType;

  NotificationData(
      {this.countryCode,
      this.sentByUser,
      this.mobileNumber,
      this.notificationType});

  NotificationData.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    sentByUser = json['sent_by_user'];
    mobileNumber = json['mobile_number'];
    notificationType = json['notification_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = countryCode;
    data['sent_by_user'] = sentByUser;
    data['mobile_number'] = mobileNumber;
    data['notification_type'] = notificationType;
    return data;
  }
}

class SentByUser {
  int? userId;
  String? mediumProfileImg;

  SentByUser({this.userId, this.mediumProfileImg});

  SentByUser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    mediumProfileImg = json['medium_profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['medium_profile_img'] = mediumProfileImg;
    return data;
  }
}
