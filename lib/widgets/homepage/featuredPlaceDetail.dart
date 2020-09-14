import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants.dart';
import '../../utils/stringCapitalizer.dart';

class FeaturedPlaceDetail extends StatelessWidget {
  const FeaturedPlaceDetail({
    Key key,
    this.place,
  }) : super(key: key);
  final QueryDocumentSnapshot place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 190.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
              color: kPrimaryColor.withOpacity(0.2),
              offset: Offset(0, 8),
              blurRadius: 5.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.get('name').toLowerCase().toString().capitalize(),
            style: TextStyle(
                fontSize: ScreenUtil().setSp(16.0),
                fontWeight: FontWeight.w600),
          ),
          Divider(color: kPrimaryColor),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: kDarkPrimaryColor),
                  SizedBox(width: 7.w),
                  Text(
                    '${place.get('likes')}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(width: 30.w),
              Row(
                children: [
                  Icon(Icons.message, color: kDarkPrimaryColor),
                  SizedBox(width: 7.w),
                  Text(
                    '8',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w600,
                    ),
                    //TODO add reviews.
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
