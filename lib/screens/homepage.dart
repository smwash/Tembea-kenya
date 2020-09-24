import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tembea_user/widgets/homepage/mostVisited.dart';
import 'package:tembea_user/widgets/homepage/placeCategory.dart';

import '../utils/constants.dart';
import '../widgets/homepage/allPlaces.dart';
import '../widgets/homepage/featuredPlaces.dart';
import '../widgets/homepage/popularPlaces.dart';
import '../widgets/homepage/profilePic.dart';
import '../widgets/homepage/searchField.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _onRefreshing() {
    print('refreshed page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScaffoldBg,
        body: RefreshIndicator(
          onRefresh: _onRefreshing,
          color: kDarkPrimaryColor,
          child: SafeArea(
            child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
              SliverAppBar(
                elevation: 0.0,
                expandedHeight: 221.h,
                centerTitle: false,
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor: kScaffoldBg,
                title: Image.asset('assets/images/home_logo.png'),
                actions: [
                  ProfilePicture(),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    overflow: Overflow.visible,
                    children: [
                      FeaturedPlaces(),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: SearchField()),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 8.h),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    Container(
                      height: 220.h,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Column(
                        children: [
                          buildCatTitle('Fan Favorite'),
                          SizedBox(height: 5.h),
                          PopularPlaces(),
                          SizedBox(height: 5.h),
                          // RaisedButton.icon(
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //   ),
                          //   color: kDarkPrimaryColor,
                          //   elevation: 0.0,
                          //   icon: Icon(
                          //     Icons.wallet_travel,
                          //     size: ScreenUtil().setSp(20),
                          //     color: Colors.white,
                          //   ),
                          //   label: Text(
                          //     'KWS Park entry fee',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: ScreenUtil().setSp(15.5),
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //   ),
                          //   onPressed: () {},
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    PlaceCategory(),
                    SizedBox(height: 12.h),
                    Container(
                      height: 225.h,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Column(
                        children: [
                          buildCatTitle('Most Visited'),
                          SizedBox(height: 5.h),
                          MostVisitedPlaces(),
                          //SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    buildCatTitle('Top Places'),
                    AllPlaces(),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  Container buildContainer() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setSp(5)),
      margin: EdgeInsets.only(right: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: ScreenUtil().setSp(20),
        backgroundColor: kPrimaryColor,
        //backgroundImage: CachedNetworkImageProvider(user.photoUrl),
      ),
    );
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
