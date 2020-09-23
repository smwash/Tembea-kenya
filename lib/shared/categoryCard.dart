import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';

class CategoryCard extends StatelessWidget {
  final GestureTapCallback press;
  final String text;
  final IconData icon;

  const CategoryCard({
    Key key,
    @required this.press,
    @required this.text,
    @required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 65.w,
        height: 89.h,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        margin: EdgeInsets.symmetric(horizontal: 9.w),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: ScreenUtil().setSp(30),
              color: kDarkPrimaryColor,
            ),
            SizedBox(height: 7.h),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      onTap: press,
    );
  }
}
