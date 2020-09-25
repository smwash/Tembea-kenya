import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/widgets/trips/emptyList.dart';
import '../model/place.dart';
import '../widgets/trips/saveCard.dart';
import '../model/user.dart';
import '../providers/user.dart';
import '../services/database.dart';
import '../utils/constants.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    UserProvider places = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        title: Text(
          'BookMarks',
          style: TextStyle(
            // color: Colors.black,
            fontSize: ScreenUtil().setSp(19),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),
            child: RaisedButton.icon(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: places.getSavedPlaces.isEmpty
                  ? kPrimaryColor.withOpacity(0.6)
                  : kPrimaryColor.withOpacity(0.2),
              icon: Icon(Icons.delete),
              label: Text(
                'Delete All',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onPressed: () async {
                final user = Provider.of<UserData>(context, listen: false);
                try {
                  places.deleteAllSavedPlaces(userId: user.userId);
                } catch (error) {}
              },
            ),
          )
        ],
      ),
      body: places.getUserSavedPlaces.length == 0
          ? EmptyList()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 10.h),
              itemCount: places.getUserSavedPlaces.length,
              itemBuilder: (context, index) {
                Places place = places.getUserSavedPlaces[index];
                return SaveCard(place: place);
              },
            ),
    );
  }
}
