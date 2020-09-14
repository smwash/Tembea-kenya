import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tembea_user/model/user.dart';

class Database {
  final _db = FirebaseFirestore.instance;

  Future<void> addUser(UserData user) async {
    return _db.collection('users').doc(user.userId).set(user.toMap());
  }

  Stream getPlaces() {
    return _db.collection('places').snapshots();
  }

  Future<void> updateData(String id) async {
    SetOptions options = SetOptions(merge: true);
    return _db.collection('users').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.set({
          'savedPlaces': [id],
        }, options);
      });
    });
  }
}
