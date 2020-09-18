import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tembea_user/model/place.dart';
import 'package:tembea_user/model/user.dart';
import 'package:tembea_user/services/database.dart';

class UserProvider with ChangeNotifier {
  String _email;
  bool _isSaved = false;
  String _userId;
  String _photoUrl;
  String _userName;
  DateTime _dateJoined;
  List _savedPlaces = [];

  //Getters:
  bool get savedStatus => _isSaved;
  String get userEmail => _email;
  String get userID => _userId;
  String get userPhoto => _photoUrl;
  String get userName => _userName;
  DateTime get memberSince => _dateJoined;
  UnmodifiableListView get getSavedPlaces => UnmodifiableListView(_savedPlaces);

  //SETTERS:
  setParameters(UserData user) {
    _email = user.email;
    _photoUrl = user.photoUrl;
    _userName = user.userName;
    _dateJoined = user.dateJoined;
    _savedPlaces = user.savedPlaces;
    notifyListeners();
  }

  set setSavedList(List<String> savedPlaces) {
    _savedPlaces = savedPlaces;
    notifyListeners();
  }

  set setIsSaved(bool isSaved) {
    _isSaved = isSaved;
    notifyListeners();
  }

  updateSavedStatus({String userId, String placeId}) {
    Database()
        .updateSavedStatus(userId: userId, placeId: placeId)
        .then((result) {
      if (result == true) {
        if (!_savedPlaces.contains(placeId)) {
          _isSaved = true;
          _savedPlaces.add(placeId);
        } else {
          _isSaved = false;
          _savedPlaces.remove(placeId);
          //_isSaved = false;
        }
        notifyListeners();
      }
    });
  }
}
