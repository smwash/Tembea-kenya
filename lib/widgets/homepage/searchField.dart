import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tembea_user/utils/constants.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 300.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      //margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.4),
              offset: Offset(0, 5),
              blurRadius: 5.0,
            ),
          ]),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search location..',
          suffixIcon: Container(
            height: 30.h,
            width: 30.w,
            margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor,
                    blurRadius: 5.0,
                  ),
                ]),
            child: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
