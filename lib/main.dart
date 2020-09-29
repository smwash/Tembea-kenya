import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './services/connectivity.dart';
import './utils/connectivityEnums.dart';
import './utils/theme.dart';
import './providers/themeProvider.dart';
import './model/user.dart';
import './providers/placeProvider.dart';
import './providers/user.dart';

import './utils/loader.dart';
import './widgets/bottomNav.dart';

import 'screens/welcomeScreen.dart';
import 'services/authService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences.getInstance().then(
    (prefs) {
      return runApp(
        MyApp(prefs: prefs),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key key, this.prefs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(
            value: ThemeProvider(prefs)),
        StreamProvider<UserData>.value(value: AuthService().user),
        ChangeNotifierProvider(
          create: (context) => PlaceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        StreamProvider<ConnectivityStatus>(
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
        )
      ],
      child: MyApplication(),
    );
  }
}

class MyApplication extends StatelessWidget {
  const MyApplication({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tembea',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).isDarkMode
          ? darkTheme
          : lightTheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          if (snapshot.data is User && snapshot.data != null) {
            return BottomNav();
          }
          return WelcomeScreen();
        },
      ),
    );
  }
}
