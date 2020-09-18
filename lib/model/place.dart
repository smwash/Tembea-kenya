import 'package:cloud_firestore/cloud_firestore.dart';

class Places {
  List likes;
  String name;
  String time;
  double distance;
  List gallery;
  List visitedBy;
  String placeId;
  List activities;
  String coverPhoto;
  String description;

  Places.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    placeId = doc.id;
    time = data['time'];
    name = data['name'];
    likes = data['likes'];
    gallery = data['gallery'];
    distance = data['distance'].toDouble();
    visitedBy = data['visitedBy'];
    activities = data['activities'];
    coverPhoto = data['coverPhoto'];
    description = data['description'];
  }
}
