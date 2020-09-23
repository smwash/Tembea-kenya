import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tembea_user/utils/constants.dart';

AppBar categoryAppBar(
    {@required BuildContext context, @required String title}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1.5,
    leading: Padding(
      padding: EdgeInsets.all(8.h),
      child: GestureDetector(
        child: CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onTap: () => Navigator.pop(context),
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: ScreenUtil().setSp(19),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    ),
  );
}
