import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          SizedBox(height: 35.h),
          Expanded(
            //flex: 2,
            child: Image.asset('assets/images/emptySaveList.png'),
          ),
          SizedBox(height: 35.h),
          Expanded(
            child: Text(
              'No saved places yet',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(17),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
