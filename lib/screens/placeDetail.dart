import 'package:cached_network_image/cached_network_image.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/model/place.dart';
import 'package:tembea_user/services/database.dart';
import 'package:tembea_user/utils/constants.dart';
import 'package:tembea_user/widgets/placeDetail/activities.dart';
import 'package:tembea_user/widgets/placeDetail/description.dart';
import 'package:tembea_user/widgets/placeDetail/secondRow.dart';
import 'package:tembea_user/widgets/placeDetail/sliverCarousel.dart';
import 'package:tembea_user/widgets/placeDetail/topRow.dart';
import 'package:tembea_user/widgets/placeDetail/visitRow.dart';
import '../utils/stringCapitalizer.dart';

class PlaceDetail extends StatelessWidget {
  final Places place;

  const PlaceDetail({Key key, @required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBg,
      body: Hero(
        tag: place.placeId,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 2.0,
              backgroundColor: Colors.white,
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
                  color: Colors.white,
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
                color: Colors.white,
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
