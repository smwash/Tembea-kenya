import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tembea_user/utils/constants.dart';
import 'package:tembea_user/utils/pageAnimation.dart';

import 'authScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 400.0, height: 810.0, allowFontScaling: true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: ScreenUtil().uiHeightPx,
          width: ScreenUtil().uiWidthPx,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 15.h),
              Flexible(
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              SizedBox(height: 20.h),
              Flexible(
                child: Image.asset(
                  'assets/images/welcome.png',
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                'Ready To Discover?',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(18.0),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 23.h),
              Text(
                'Save your liked places, view the most visited and liked places.Invite friends, plan and travel together.See your travel ranking.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16.5),
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  wordSpacing: 1.1,
                ),
              ),
              SizedBox(height: 15.h),
              InkWell(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                  height: 55.h,
                  width: 210.w,
                  decoration: BoxDecoration(
                    //color: kPrimaryColor,
                    gradient: kLinearGradient,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  EnterExitRoute(
                    exitPage: SplashScreen(),
                    enterPage: AuthScreen(),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
