import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/place.dart';
import '../widgets/placeDetail/placeReviews.dart';
import '../utils/constants.dart';
import '../widgets/placeDetail/activities.dart';
import '../widgets/placeDetail/description.dart';
import '../widgets/placeDetail/secondRow.dart';
import '../widgets/placeDetail/sliverCarousel.dart';
import '../widgets/placeDetail/topRow.dart';
import '../widgets/placeDetail/visitRow.dart';

class PlaceDetail extends StatelessWidget {
  final Places place;

  const PlaceDetail({Key key, @required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: place.placeId,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 2.0,
              expandedHeight: 400.h,
              leading: Padding(
                padding: EdgeInsets.all(ScreenUtil().setSp(6.5)),
                child: GestureDetector(
                  child: CircleAvatar(
                      backgroundColor: kDarkPrimaryColor,
                      child: Icon(Icons.arrow_back, color: Colors.white)),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              pinned: true,
              floating: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                background: SliverCarousel(place: place),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 16.h),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PlaceDetailTopRow(place: place),
                    SizedBox(height: 13.h),
                    SecondRowUpper(place: place),
                    Divider(
                      color: kPrimaryColor.withOpacity(0.5),
                      thickness: 1.0,
                    ),
                    SizedBox(height: 10.h),
                    buildTitle(' OverView'),
                    SizedBox(height: 5.h),
                    PlaceDetailDescription(place: place),
                    SizedBox(height: 12.h),
                    buildTitle(' Activities'),
                    SizedBox(height: 5.h),
                    PlaceActivities(place: place),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 16.h),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
                  child: Column(
                    children: [
                      buildTitle(' Reviews'),
                      SizedBox(height: 10.h),
                      Divider(
                        color: kPrimaryColor.withOpacity(0.7),
                        thickness: 1.0,
                      ),
                      SizedBox(height: 5.h),
                      VisitRow(place: place),
                      SizedBox(height: 5.h),
                      Divider(
                        color: kPrimaryColor.withOpacity(0.7),
                        thickness: 1.0,
                      ),
                      PlaceReviews(place: place),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 16.h),
            ),
          ],
        ),
      ),
    );
  }

  Row buildTitle(String label) {
    return Row(
      children: [
        Text(
          '•',
          style: TextStyle(
            color: kDarkPrimaryColor,
            fontSize: ScreenUtil().setSp(25),
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
