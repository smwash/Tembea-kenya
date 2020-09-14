import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundIconNameBtn extends StatelessWidget {
  const RoundIconNameBtn({
    Key key,
    this.label,
    this.icon,
    this.onPress,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 47.h,
        width: 170.w,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: ScreenUtil().setSp(40),
              color: Colors.white,
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.1,
                fontSize: ScreenUtil().setSp(18.5),
              ),
            ),
          ],
        ),
      ),
      onTap: onPress,
    );
  }
}
