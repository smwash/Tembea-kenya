import 'dart:collection';

import 'package:flutter/material.dart';
import '../model/place.dart';
import '../model/user.dart';
import '../services/database.dart';

class UserProvider with ChangeNotifier {
  String _email;
  bool _isSaved = false;
  String _userId;
  String _photoUrl;
  String _userName;
  DateTime _dateJoined;
  List _savedPlaces = [];
  List<Places> _userPlaces = [];

  //Getters:
  bool get savedStatus => _isSaved;
  String get userEmail => _email;
  String get userID => _userId;
  String get userPhoto => _photoUrl;
  String get userName => _userName;
  DateTime get memberSince => _dateJoined;
  UnmodifiableListView get getSavedPlaces => UnmodifiableListView(_savedPlaces);
  List<Places> get getUserSavedPlaces => UnmodifiableListView(_userPlaces);

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

  set setUserSavedList(List<Places> savedPlaces) {
    _userPlaces = savedPlaces;
    notifyListeners();
  }

  set setIsSaved(bool isSaved) {
    _isSaved = isSaved;
    notifyListeners();
  }

  deleteAllSavedPlaces({String userId}) async {
    try {
      if (_savedPlaces.isNotEmpty && _userPlaces.isNotEmpty) {
        _savedPlaces.clear();
        await Database().deleteAllSavedPlaces(userId);
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  updateLocalSaveStatus({String userId, String placeId}) {
    if (!_savedPlaces.contains(placeId)) {
      _savedPlaces.add(placeId);
      _isSaved = true;
      Database().addToSavedPlaces(userId: userId, placeId: placeId);
      print('$placeId added to db');
    } else {
      _savedPlaces.remove(placeId);
      _isSaved = false;
      Database().removeFromSavedPlaces(userId: userId, placeId: placeId);
      print('$placeId removed from db');
    }
    notifyListeners();
  }

  // updateSavedStatus({String userId, String placeId}) {
  //   Database()
  //       .updateSavedStatus(userId: userId, placeId: placeId)
  //       .then((result) {
  //     if (!_savedPlaces.contains(placeId)) {
  //       _isSaved = true;
  //       _savedPlaces.add(placeId);
  //       print('$placeId added to db');
  //     } else {
  //       _isSaved = false;
  //       _savedPlaces.remove(placeId);
  //       print('$placeId removed from db');
  //     }
  //   });
  //   notifyListeners();
  // }
}
