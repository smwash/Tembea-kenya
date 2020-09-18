import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tembea_user/model/place.dart';
import 'package:tembea_user/model/user.dart';

class PlaceProvider with ChangeNotifier {
  List<Places> _allPlaces = [];
  List<Places> _fanFavorites = [];

  List<Places> _featuredPlaces = [];
  List<Places> _mostVisitedPlaces = [];
  int _likes;
  bool _isLiked;

  //GETTERS:
  UnmodifiableListView<Places> get getAllPlaces =>
      UnmodifiableListView(_allPlaces);

  UnmodifiableListView<Places> get getFeaturedPlaces =>
      UnmodifiableListView(_featuredPlaces);

  UnmodifiableListView<Places> get getFanFavPlaces =>
      UnmodifiableListView(_fanFavorites);

  UnmodifiableListView<Places> get getmostVisitedPlaces =>
      UnmodifiableListView(_mostVisitedPlaces);

  int get getLikes => _likes;
  bool get isLiked => _isLiked;

  //SETTERS:
  set allPlaces(List<Places> allPlaces) {
    _allPlaces = allPlaces;
    notifyListeners();
  }

  set setFanFavPlaces(List<Places> fanFavPlaces) {
    _fanFavorites = fanFavPlaces;
    notifyListeners();
  }

  set setFeaturedPlaces(List<Places> featuredPlaces) {
    _featuredPlaces = featuredPlaces;
    notifyListeners();
  }

  placeIsLiked() {}

  set likes(int likes) {
    _likes = likes;
    notifyListeners();
  }
}
