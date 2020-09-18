import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String email;
  String userId;
  String photoUrl;
  String userName;
  List savedPlaces;
  DateTime dateJoined;

  UserData({
    this.userId,
    this.email,
    this.userName,
    this.photoUrl,
    this.dateJoined,
    this.savedPlaces,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userId': userId,
      'photoUrl': photoUrl,
      'userName': userName,
      'savedPlaces': savedPlaces,
      'dateJoined': dateJoined.toIso8601String(),
    };
  }

  UserData.fromFirestore(Map<String, dynamic> doc)
      : email = doc['email'],
        userId = doc['userId'],
        userName = doc['userName'],
        photoUrl = doc['photoUrl'],
        savedPlaces = doc['savedPlaces'],
        dateJoined = DateTime.parse(doc['dateJoined']);
}
