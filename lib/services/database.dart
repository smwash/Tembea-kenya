import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tembea_user/model/review.dart';

import '../model/place.dart';
import '../model/user.dart';
import '../providers/placeProvider.dart';
import '../providers/user.dart';

class Database {
  final _db = FirebaseFirestore.instance;

//User:
  Future<void> addUser(UserData user) async {
    return _db.collection('users').doc(user.userId).set(user.toMap());
  }

  getUserData({UserData user, UserProvider userProvider}) async {
    try {
      UserData snapshot = await _db
          .collection('users')
          .doc(user.userId)
          .get()
          .then((snapshot) => UserData.fromFirestore(snapshot.data()));
      userProvider.setParameters(snapshot);
    } catch (error) {
      print(error);
    }
  }

  Future<void> addToSavedPlaces({String userId, String placeId}) async {
    return await _db.collection('users').doc(userId).update({
      'savedPlaces': FieldValue.arrayUnion([placeId])
    });
  }

  Future<void> removeFromSavedPlaces({String userId, String placeId}) async {
    return await _db.collection('users').doc(userId).update({
      'savedPlaces': FieldValue.arrayRemove([placeId])
    });
  }

  Future<void> deleteAllSavedPlaces(String userId) async {
    try {
      return await _db
          .collection('users')
          .doc(userId)
          .update({'savedPlaces': []});
    } catch (error) {
      print(error);
    }
  }

  querySavedPlaces({List queryIds, UserProvider userProvider}) async {
    try {
      List<Places> _savedPlaces = [];
      queryIds.forEach((query) async {
        QuerySnapshot snapshot = await _db
            .collection('places')
            .where(FieldPath.documentId, isEqualTo: query)
            .get();
        snapshot.docs.forEach((doc) {
          Places places = Places.fromFirestore(doc);
          _savedPlaces.add(places);
        });
        userProvider.setUserSavedList = _savedPlaces;
      });
    } catch (error) {
      print(error);
    }
  }

  getAllPlaces(PlaceProvider placeProvider) async {
    try {
      QuerySnapshot snapshot = await _db.collection('places').get();
      List<Places> _allPlaces = [];
      snapshot.docs.forEach((doc) {
        Places places = Places.fromFirestore(doc);
        _allPlaces.add(places);
      });
      placeProvider.allPlaces = _allPlaces;
    } catch (error) {
      print(error);
    }
  }

  getUserSavedPlaces({UserProvider userProvider, String userId}) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('users').doc(userId).get();
      List<String> _savedPlaces = [];
      snapshot.data()['savedPlaces'].forEach((doc) {
        _savedPlaces.add(doc);
        print(doc.length);
      });

      userProvider.setSavedList = _savedPlaces;
    } catch (error) {}
  }

  getFeaturedPlaces(PlaceProvider placeProvider) async {
    try {
      QuerySnapshot snapshot = await _db.collection('places').limit(5).get();
      List<Places> _featuredPlaces = [];
      snapshot.docs.forEach((doc) {
        Places places = Places.fromFirestore(doc);
        _featuredPlaces.add(places);
      });
      placeProvider.setFeaturedPlaces = _featuredPlaces;
    } catch (error) {
      print(error);
    }
  }

  getMostVisitedPlaces(PlaceProvider placeProvider) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('places')
          .limit(9)
          .orderBy('visitedBy', descending: true)
          .get();
      List<Places> _places = [];
      snapshot.docs.forEach((doc) {
        Places places = Places.fromFirestore(doc);
        _places.add(places);
      });
      placeProvider.setMostVisitedPlaces = _places;
    } catch (error) {}
  }

  getfanFavPlaces(PlaceProvider placeProvider) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('places')
          .limit(8)
          .orderBy('likes', descending: true)
          .get();
      List<Places> _fanFavPlaces = [];
      snapshot.docs.forEach((doc) {
        Places places = Places.fromFirestore(doc);
        _fanFavPlaces.add(places);
      });
      placeProvider.setFanFavPlaces = _fanFavPlaces;
    } catch (error) {
      print(error);
    }
  }

  getNationalParks(PlaceProvider placeProvider) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('places')
          .where('category', isEqualTo: 'nationalPark')
          .get();
      List<Places> _parks = [];
      snapshot.docs.forEach((doc) {
        Places places = Places.fromFirestore(doc);
        _parks.add(places);
      });
      placeProvider.setNationalParks = _parks;
    } catch (error) {
      print(error);
    }
  }

  getMarineParks(PlaceProvider placeProvider) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('places')
          .where('category', isEqualTo: 'marinePark')
          .get();
      List<Places> _parks = [];
      snapshot.docs.forEach((doc) {
        Places places = Places.fromFirestore(doc);
        _parks.add(places);
      });
      placeProvider.setMarineParks = _parks;
    } catch (error) {
      print(error);
    }
  }

  getSafariWalk(PlaceProvider placeProvider) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('places')
          .where('category', isEqualTo: 'safariwalk')
          .get();
      List<Places> _parks = [];
      snapshot.docs.forEach((doc) {
        Places places = Places.fromFirestore(doc);
        _parks.add(places);
      });
      placeProvider.setSafariwalk = _parks;
    } catch (error) {
      print(error);
    }
  }

  getOrphanage(PlaceProvider placeProvider) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('places')
          .where('category', isEqualTo: 'orphanage')
          .get();
      List<Places> _parks = [];
      snapshot.docs.forEach((doc) {
        Places places = Places.fromFirestore(doc);
        _parks.add(places);
      });
      placeProvider.setOrphanage = _parks;
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateData() async {
    SetOptions options = SetOptions(merge: true);
    //GetOptions options = GetOptions(merge: true);
    return _db.collection('places').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.update({
          'category': 'nationalPark',
        });
      });
    });
  }

  Future<void> updateUserSaveStatus(
      {String userId, UserProvider userProvider, String placeId}) async {
    DocumentSnapshot docSnapshot =
        await _db.collection('users').doc(userId).get();
    if (docSnapshot.data()['savedPlaces'].contains(placeId)) {
      userProvider.setIsSaved = true;
    } else {
      userProvider.setIsSaved = false;
    }
  }

  //LIKES:

  Future<void> updateUserLikeStatus(
      {String userId, PlaceProvider placeProvider, String placeId}) async {
    DocumentSnapshot docSnapshot =
        await _db.collection('places').doc(placeId).get();
    placeProvider.setPlaceLikes = docSnapshot.data()['likes'];
    if (docSnapshot.data()['likes'].contains(userId)) {
      placeProvider.placeIsLiked = true;
    } else {
      placeProvider.placeIsLiked = false;
    }
  }

  Future<void> removeLike({String placeId, String userId}) async {
    return await _db.collection('places').doc(placeId).update({
      'likes': FieldValue.arrayRemove([userId])
    });
  }

  Future<void> addLike({String placeId, String userId}) async {
    return await _db.collection('places').doc(placeId).update({
      'likes': FieldValue.arrayUnion([userId])
    });
  }

  //VISITED:
  Future<void> updateUserVisits(
      {String userId, PlaceProvider placeProvider, String placeId}) async {
    DocumentSnapshot docSnapshot =
        await _db.collection('places').doc(placeId).get();
    placeProvider.setPlaceViists = docSnapshot.data()['visitedBy'];
    if (docSnapshot.data()['visitedBy'].contains(userId)) {
      placeProvider.placeIsVisited = true;
    } else {
      placeProvider.placeIsVisited = false;
    }
  }

  Future<void> removeUserVisit({String placeId, String userId}) async {
    return await _db.collection('places').doc(placeId).update({
      'visitedBy': FieldValue.arrayRemove([userId])
    });
  }

  Future<void> addUserVisit({String placeId, String userId}) async {
    return await _db.collection('places').doc(placeId).update({
      'visitedBy': FieldValue.arrayUnion([userId])
    });
  }

  //REVIEWS:
  Future<void> addPlaceReview({String placeId, Review review}) async {
    await _db
        .collection('places')
        .doc(placeId)
        .collection('reviews')
        .doc(review.reviewId)
        .set(review.toMap());
  }

  getPlaceReviews({String placeId, PlaceProvider placeProvider}) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('places')
          .doc(placeId)
          .collection('reviews')
          .get();
      List<Review> _reviews = [];
      snapshot.docs.forEach((doc) {
        Review review = Review.fromFirestore(doc.data());
        _reviews.add(review);
      });
      placeProvider.setReviewList = _reviews;
    } catch (error) {
      print(error);
    }
  }
}
