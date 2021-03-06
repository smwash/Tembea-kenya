import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/place.dart';

class PlaceActivities extends StatelessWidget {
  final Places place;

  const PlaceActivities({Key key, this.place}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7.w,
      runSpacing: 4.h,
      children: place.activities.map<Widget>((activity) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Color(0xfffadcac),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            activity,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }
}
