class UserData {
  String email;
  String userId;
  String photoUrl;
  String userName;
  DateTime dateJoined;

  UserData({
    this.userId,
    this.email,
    this.userName,
    this.photoUrl,
    this.dateJoined,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userId': userId,
      'photoUrl': photoUrl,
      'userName': userName,
      'dateJoined': dateJoined.toIso8601String(),
    };
  }

  UserData.fromFirestore(Map<String, dynamic> doc)
      : email = doc['email'],
        userId = doc['userId'],
        userName = doc['userName'],
        photoUrl = doc['photoUrl'],
        dateJoined = DateTime.parse(doc['dateJoined']);
}
