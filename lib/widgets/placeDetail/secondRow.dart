import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tembea_user/model/place.dart';

import 'package:tembea_user/utils/constants.dart';

class SecondRowUpper extends StatelessWidget {
  const SecondRowUpper({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Places place;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite, color: kDarkPrimaryColor),
                SizedBox(width: 6.w),
                Text(
                  '${place.likes.length} likes',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.message, color: kDarkPrimaryColor),
                SizedBox(width: 6.w),
                Text(
                  '8 reviews',
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(MdiIcons.mapMarkerDistance, color: kDarkPrimaryColor),
                SizedBox(width: 6.w),
                Text(
                  '${place.distance}Km from Nairobi',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.access_time, color: kDarkPrimaryColor),
                SizedBox(width: 6.w),
                Text(
                  '${place.time}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
