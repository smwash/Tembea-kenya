import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tembea_user/model/place.dart';
import 'package:tembea_user/model/user.dart';
import 'package:tembea_user/providers/placeProvider.dart';
import 'package:tembea_user/providers/user.dart';

class Database {
  final _db = FirebaseFirestore.instance;

//User:
  Future<void> addUser(UserData user) async {
    return _db.collection('users').doc(user.userId).set(user.toMap());
  }

  getUserData({UserData user, UserProvider userProvider}) async {
    try {} catch (error) {
      print(error);
    }
    UserData snapshot = await _db
        .collection('users')
        .doc(user.userId)
        .get()
        .then((snapshot) => UserData.fromFirestore(snapshot.data()));
    //print(snapshot.userName);
    userProvider.setParameters(snapshot);
  }

  Future<void> addToSavedPlaces({String userId, Places placeId}) async {
    return await _db.collection('users').doc(userId).update({
      'savedPlaces': FieldValue.arrayUnion([placeId])
    });
  }

  Future<void> removeFromSavedPlaces({String userId, String id}) async {
    return await _db.collection('users').doc(userId).update({
      'savedPlaces': FieldValue.arrayRemove([id])
    });
  }

  Future<void> querySavedPlaces(String queryId) async {
    return await _db
        .collection('users')
        .limit(1)
        .where('savedPlaces', isEqualTo: queryId)
        .get();
  }

  // Likes:
  Future<void> incrementLikes({String docId, String userId}) async {
    return await _db.collection('places').doc(docId).update({
      'likes': FieldValue.arrayUnion([docId])
    });
  }

  Future<void> decrementLikes({String docId, String userId}) async {
    return await _db.collection('places').doc(docId).update({
      'likes': FieldValue.arrayRemove([docId])
    });
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

  getfanFavPlaces(PlaceProvider placeProvider) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('places')
          .limit(7)
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

  updateSavedPlaces() {}

  // queryLikedPlacesbyUser(PlaceProvider placeProvider) async {
  //    await _db
  //       .collection('users')
  //       .limit(1)
  //       .where('savedPlaces', isEqualTo: queryId)
  //       .get();
  // }

  getLikesCount(PlaceProvider placeProvider) async {
    int likes =
        await _db.collection('places').where('likes').snapshots().length;
    placeProvider.likes = likes;
  }

  Future<void> updateData() async {
    SetOptions options = SetOptions(merge: true);
    //GetOptions options = GetOptions(merge: true);
    return _db.collection('places').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.update({
          'likes': [],
          'visitedBy': [],
        });
      });
    });
  }

  Future<void> addSavedPlace({String userId, String id}) async {
    SetOptions options = SetOptions(merge: true);
    return await _db.collection('users').doc(userId).update({
      'savedPlaces': {'one': id}
    });
  }

  //  Future<void> addFavPlace({String userId, String id}) async {
  //   SetOptions options = SetOptions(merge: true);
  //   return await _db.collection('users').get().then((snapshot){
  //     snapshot.docs.
  //   })

  //   .update({
  //     'savedPlaces': {id}
  //   });
  // }

  Future<bool> updateSavedStatus({String userId, String placeId}) async {
    DocumentReference savedPlacesRef = _db.collection('users').doc(userId);

    return _db.runTransaction((transaction) async {
      DocumentSnapshot placeSnapshot = await transaction.get(savedPlacesRef);
      if (placeSnapshot.exists) {
        if (!placeSnapshot.data()['savedPlaces'].contains(placeId)) {
          transaction.update(savedPlacesRef, {
            'savedPlaces': FieldValue.arrayUnion([placeId])
          });
        } else {
          transaction.update(savedPlacesRef, {
            'savedPlaces': FieldValue.arrayRemove([placeId])
          });
        }
      } else {
        transaction.set(savedPlacesRef, {
          'savedPlaces': [placeId]
        });
      }
    }).then((value) {
      //userProvider.setIsSaved = true;
      return true;
    }).catchError((error) {
      //userProvider.setIsSaved = false;
      return false;
    });
    // } catch (error) {
    //   print(error);
    // }
  }

  //    getUserPlaces(String userId, UserProvider userProvider) {
  //   Stream<DocumentSnapshot> querySnapshot =  _db
  //       .collection('users')
  //       .doc(userId)
  //       .snapshots();
  //   if (querySnapshot != null &&
  //       querySnapshot.  .data().containsKey('savedPlaces') &&
  //       querySnapshot.data()['savedPlaces'] is List) {
  //     // Create a new List<String> from List<dynamic>
  //     List<String> savedPlaces = [];
  //      List<String>.from(querySnapshot.data()['savedPlaces']);
  //      querySnapshot.data()['savedPlaces'].forEach((place){
  //        savedPlaces.add(place);
  //      });
  //      userProvider.setSavedList = savedPlaces;
  //   }

  // }
}

//update({'likes': FieldValue.delete()});
