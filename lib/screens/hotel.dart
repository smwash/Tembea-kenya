import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../shared/categoryAppbar.dart';
import '../utils/constants.dart';

class Hotels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBg,
      appBar: categoryAppBar(context: context, title: 'Hotels'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 35.h),
            Expanded(
              //flex: 2,
              child: Image.asset('assets/images/hotel.png'),
            ),
            SizedBox(height: 35.h),
            Expanded(
              child: Text(
                'Coming Soon...',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(17),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
