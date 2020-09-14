import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/utils/constants.dart';
import '../../utils/stringCapitalizer.dart';

class PopularPlacesCard extends StatelessWidget {
  const PopularPlacesCard({
    Key key,
    @required this.place,
  }) : super(key: key);

  final QueryDocumentSnapshot place;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 165.h,
          width: 120.w,
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              imageUrl: place.get('coverPhoto'),
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.grey[350],
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    height: 170.h,
                    width: 120.w),
              ),
            ),
          ),
        ),
        Positioned(
          right: 6.w,
          top: 5.5.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Icon(Icons.favorite, color: kDarkPrimaryColor),
                SizedBox(width: 3.w),
                Text(
                  '${place.get('likes')}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 5.w,
          left: 5.w,
          child: Container(
            width: 120.w,
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
            alignment: Alignment.bottomLeft,
            child: Text(
              '${place.get('name').toString().capitalize()}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(12.5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
