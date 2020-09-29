import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/homepage/mostVisited.dart';
import '../widgets/homepage/placeCategory.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          elevation: 0.0,
          expandedHeight: 221.h,
          centerTitle: false,
          pinned: true,
          floating: true,
          snap: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Image.asset('assets/images/home_logo.png'),
          actions: [
            ProfilePicture(),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              overflow: Overflow.visible,
              children: [
                FeaturedPlaces(),
                Align(alignment: Alignment.bottomCenter, child: SearchField()),
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
                color: Theme.of(context).canvasColor,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  children: [
                    buildCatTitle('Fan Favorite'),
                    SizedBox(height: 5.h),
                    PopularPlaces(),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              PlaceCategory(),
              SizedBox(height: 12.h),
              Container(
                height: 225.h,
                color: Theme.of(context).canvasColor,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  children: [
                    buildCatTitle('Most Visited'),
                    SizedBox(height: 5.h),
                    MostVisitedPlaces(),
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
