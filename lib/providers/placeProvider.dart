import 'dart:collection';

import 'package:flutter/material.dart';
import '../services/database.dart';
import '../model/place.dart';

class PlaceProvider with ChangeNotifier {
  List<Places> _allPlaces = [];
  List<Places> _fanFavorites = [];
  List<Places> _featuredPlaces = [];
  List<Places> _mostVisitedPlaces = [];
  List<Places> _nationalParks = [];
  List<Places> _marineParks = [];
  List<Places> _safariwalk = [];
  List<Places> _orphanage = [];
  List _placeLikes = [];
  List _placeVisits = [];

  bool _isLiked = false;
  bool _isVisited = false;

  //GETTERS:
  UnmodifiableListView<Places> get getAllPlaces =>
      UnmodifiableListView(_allPlaces);

  UnmodifiableListView<Places> get getFeaturedPlaces =>
      UnmodifiableListView(_featuredPlaces);

  UnmodifiableListView<Places> get getFanFavPlaces =>
      UnmodifiableListView(_fanFavorites);

  UnmodifiableListView<Places> get getmostVisitedPlaces =>
      UnmodifiableListView(_mostVisitedPlaces);
  UnmodifiableListView<Places> get getNationalParks =>
      UnmodifiableListView(_nationalParks);

  UnmodifiableListView<Places> get getMarineParks =>
      UnmodifiableListView(_marineParks);

  UnmodifiableListView<Places> get getSafariwalk =>
      UnmodifiableListView(_safariwalk);

  UnmodifiableListView<Places> get getOrphanage =>
      UnmodifiableListView(_orphanage);

  bool get isLiked => _isLiked;
  bool get isVisited => _isVisited;

  //SETTERS:
  set placeIsLiked(bool isLiked) {
    _isLiked = isLiked;
    notifyListeners();
  }

  set placeIsVisited(bool isVisited) {
    _isVisited = isVisited;
    notifyListeners();
  }

  set mostVisitedPlaces(List<Places> visitedPlaces) {
    _mostVisitedPlaces = visitedPlaces;
    notifyListeners();
  }

  set setPlaceLikes(List likes) {
    _placeLikes = likes;
    notifyListeners();
  }

  set setPlaceViists(List visits) {
    _placeVisits = visits;
    notifyListeners();
  }

  set setNationalParks(List<Places> nationalParks) {
    _nationalParks = nationalParks;
    notifyListeners();
  }

  set setMarineParks(List<Places> marineParks) {
    _marineParks = marineParks;
    notifyListeners();
  }

  set setSafariwalk(List<Places> safariwalk) {
    _safariwalk = safariwalk;
    notifyListeners();
  }

  set setOrphanage(List<Places> orphanage) {
    _orphanage = orphanage;
    notifyListeners();
  }

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

  updateLikeStatus({String placeId, String userId}) async {
    try {
      if (!_placeLikes.contains(userId)) {
        _isLiked = true;
        _placeLikes.add(userId);
        await Database().addLike(placeId: placeId, userId: userId);
        print('$userId added');
      } else {
        _isLiked = false;
        _placeLikes.remove(userId);
        await Database().removeLike(placeId: placeId, userId: userId);
        print('$userId removed');
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  updateVisitStatus({String placeId, String userId}) async {
    try {
      if (!_placeVisits.contains(userId)) {
        _isVisited = true;
        _placeVisits.add(userId);
        await Database().addUserVisit(placeId: placeId, userId: userId);
        print('$userId added');
      } else {
        _isVisited = false;
        _placeVisits.remove(userId);
        await Database().removeUserVisit(placeId: placeId, userId: userId);
        print('$userId removed');
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}
