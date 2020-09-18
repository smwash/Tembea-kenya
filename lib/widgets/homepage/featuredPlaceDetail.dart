import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tembea_user/model/place.dart';
import '../../utils/constants.dart';
import '../../utils/stringCapitalizer.dart';

class FeaturedPlaceDetail extends StatelessWidget {
  const FeaturedPlaceDetail({
    Key key,
    this.place,
  }) : super(key: key);
  final Places place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 20.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 5.w,
        runSpacing: 4.h,
        alignment: WrapAlignment.start,
        children: [
          Icon(Icons.location_on, color: kDarkPrimaryColor),
          Text(
            place.name.toLowerCase().toString().capitalize(),
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(16.0),
                fontWeight: FontWeight.w600),
          ),
          //Divider(color: kPrimaryColor),
          // Row(
          //   children: [
          //     Row(
          //       children: [
          //         Icon(Icons.favorite, color: kDarkPrimaryColor),
          //         SizedBox(width: 7.w),
          //         Text(
          //           '${place.likes.length}',
          //           style: TextStyle(
          //             fontSize: ScreenUtil().setSp(15),
          //             fontWeight: FontWeight.w600,
          //           ),
          //         )
          //       ],
          //     ),
          //     SizedBox(width: 30.w),
          //     Row(
          //       children: [
          //         Icon(Icons.message, color: kDarkPrimaryColor),
          //         SizedBox(width: 7.w),
          //         Text(
          //           '8',
          //           style: TextStyle(
          //             fontSize: ScreenUtil().setSp(15),
          //             fontWeight: FontWeight.w600,
          //           ),
          //           //TODO add reviews.
          //         )
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
