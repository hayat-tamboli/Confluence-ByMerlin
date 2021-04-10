import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String userId;
  String username;
  String name;
  String profileImage;
  String emailId;

  UserProfile(
      {this.userId, this.username, this.name, this.profileImage, this.emailId});

  UserProfile.loadUser(this.userId, this.name, this.emailId);

  UserProfile.newuser(String userId,String name,String emailId) {
    this.userId = userId;
    this.name = name;
    this.profileImage = "";
    this.emailId = emailId;
  }

  UserProfile.miniView(String userId, String name, String profileImage) {
    this.userId = userId;
    this.name = name;
    this.profileImage = profileImage;
  }

  Map<String, dynamic> miniJson() =>
      {'userId': userId, 'name': name, 'profileImage': profileImage};

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'profileImage': profileImage,
        'emailId': emailId,
        "userSearchParam": setSearchParam(name),
      };

  factory UserProfile.fromMap(Map data) {
    return UserProfile(
        userId: data['userId'],
        name: data['name'],
        profileImage: data['profileImage'],
        emailId: data['emailId']);
  }

  factory UserProfile.fromJson(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data();
    return UserProfile(
        userId: data['userId'],
        name: data['name'],
        profileImage: data['profileImage'],
        emailId: data['emailId']);
  }
}


setSearchParam(String username) {
  List<String> userSearchList = [];
  String temp = "";
  for (int i = 0; i < username.length; i++) {
    temp = temp + username[i];
    userSearchList.add(temp);
  }
  return userSearchList;
}
