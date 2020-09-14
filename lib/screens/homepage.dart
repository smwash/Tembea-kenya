import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/screens/placeDetail.dart';
import 'package:tembea_user/utils/constants.dart';
import 'package:tembea_user/widgets/homepage/allPlaces.dart';
import 'package:tembea_user/widgets/homepage/featuredPlaces.dart';
import 'package:tembea_user/widgets/homepage/popularPlaces.dart';
import '../model/user.dart';
import '../services/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot> _places;

  @override
  void initState() {
    super.initState();
    _places = Database().getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScaffoldBg,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/home_logo.png'),
                      Consumer<UserData>(
                        builder: (context, user, child) {
                          return (user == null && user.photoUrl == null)
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey[200],
                                  highlightColor: Colors.grey[350],
                                  child: CircleAvatar(
                                    radius: ScreenUtil().setSp(24),
                                  ))
                              : CircleAvatar(
                                  radius: ScreenUtil().setSp(24),
                                  backgroundImage:
                                      CachedNetworkImageProvider(user.photoUrl),
                                );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 242.h,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    children: [
                      buildCatTitle('Featured Places'),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: FeaturedPlaces(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 270.h,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      buildCatTitle('Popular Places'),
                      SizedBox(height: 5.h),
                      PopularPlaces(),
                      SizedBox(height: 5.h),
                      RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: kDarkPrimaryColor,
                        elevation: 0.0,
                        icon: Icon(
                          Icons.wallet_travel,
                          size: ScreenUtil().setSp(20),
                          color: Colors.white,
                        ),
                        label: Text(
                          'KWS Park entry fee',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(15.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                buildCatTitle('Top Places'),
                AllPlaces(),
              ],
            ),
          ),
        ));
  }

  Padding buildCatTitle(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          label,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
