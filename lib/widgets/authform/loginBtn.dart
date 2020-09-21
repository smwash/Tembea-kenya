import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundIconNameBtn extends StatelessWidget {
  const RoundIconNameBtn({
    Key key,
    this.label,
    this.icon,
    this.color,
    this.onPress,
    this.colorText,
    this.iconColor,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Function onPress;
  final Color color;
  final Color colorText;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50.h,
        width: 268.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: ScreenUtil().setSp(40),
              color: iconColor,
            ),
            SizedBox(width: 7.w),
            Text(
              'Sign Up With $label',
              style: TextStyle(
                color: colorText,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(16),
              ),
            ),
          ],
        ),
      ),
      onTap: onPress,
    );
  }
}
