import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/model/user.dart';
import 'package:tembea_user/providers/user.dart';
import 'package:tembea_user/services/database.dart';
import 'package:tembea_user/utils/constants.dart';

class Trips extends StatefulWidget {
  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserData>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    Database().getUserData(user: user, userProvider: userProvider);
    Database().querySavedPlaces(
        queryIds: userProvider.getSavedPlaces, userProvider: userProvider);

    // .getUserPlacesFromPlaces(
    //     userProvider: userProvider, placeId: userProvider.getSavedPlaces);
    // //.getUserSavedPlaces(userId: user.userId, userProvider: userProvider);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider places = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: kScaffoldBg,
      appBar: AppBar(
        title: Text(
          'BookMarks',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(19),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: places.getSavedPlaces.length,
        itemBuilder: (context, index) {
          print(places.getUserSavedPlaces.length);
          return Text('${places.getUserSavedPlaces.length}');
        },
      ),
    );
  }
}
