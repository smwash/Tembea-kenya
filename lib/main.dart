import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './providers/themeProvider.dart';
import './model/user.dart';
import './providers/placeProvider.dart';
import './providers/user.dart';
import './screens/splashScreen.dart';
import './utils/loader.dart';
import './widgets/bottomNav.dart';

import 'services/authService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool('darkTheme') ?? false;
    return runApp(MyApp(isDarkTheme: isDarkTheme));
  });
}

class MyApp extends StatelessWidget {
  final bool isDarkTheme;

  MyApp({this.isDarkTheme});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(isDarkMode: isDarkTheme),
      ),
      StreamProvider<UserData>.value(value: AuthService().user),
      ChangeNotifierProvider(
        create: (context) => PlaceProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      )
    ], child: MaterialAppWithTheme());
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, theme, child) {
      return MaterialApp(
        title: 'Tembea',
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
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
      );
    });
  }
}
