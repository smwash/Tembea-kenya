import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/model/user.dart';
import 'package:tembea_user/providers/placeProvider.dart';
import 'package:tembea_user/providers/user.dart';
import 'package:tembea_user/screens/splashScreen.dart';
import 'package:tembea_user/utils/loader.dart';
import 'package:tembea_user/widgets/bottomNav.dart';

import 'services/authService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserData>.value(value: AuthService().user),
        ChangeNotifierProvider(
          create: (context) => PlaceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Tembea',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            }
            if (snapshot.hasData) {
              return BottomNav();
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
