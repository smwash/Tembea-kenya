import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tembea_user/model/user.dart';
import 'package:tembea_user/services/database.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _fb = FacebookLogin();
  final _db = Database();

  UserData _userFromFirebase(User user) {
    return user != null
        ? UserData(
            userId: user.uid,
            email: user.email,
            photoUrl: user.photoURL,
            userName: user.displayName,
          )
        : null;
  }

  Stream<UserData> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //googleSignin
  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      UserCredential result = await _auth.signInWithCredential(credential);

      UserData user = UserData(
        email: account.email,
        userId: result.user.uid,
        dateJoined: DateTime.now(),
        photoUrl: account.photoUrl,
        userName: account.displayName,
      );
      await _db.addUser(user);
      return _userFromFirebase(result.user);
    } catch (error) {
      print(error);
    }
  }

  //fb login
  Future fbLogin() async {
    try {
      final res = await _fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (res.status) {
        case FacebookLoginStatus.Success:
          final FacebookAccessToken fbToken = res.accessToken;
          final AuthCredential credential =
              FacebookAuthProvider.credential(fbToken.token);
          UserCredential result = await _auth.signInWithCredential(credential);
          UserData user = UserData(
            email: result.user.email,
            userId: result.user.uid,
            dateJoined: DateTime.now(),
            photoUrl: result.user.photoURL,
            userName: result.user.displayName,
          );
          await _db.addUser(user);
          return _userFromFirebase(result.user);
          break;
        case FacebookLoginStatus.Cancel:
          break;
        case FacebookLoginStatus.Error:
          print('Error while log in: ${res.error}');
          break;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (error) {}
  }
}
