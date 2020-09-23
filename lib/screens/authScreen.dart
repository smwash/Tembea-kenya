import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tembea_user/utils/constants.dart';
import 'package:tembea_user/widgets/authform/authForm.dart';
import 'package:tembea_user/widgets/authform/signUpcarousel.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SignUpCarousel(),
          Positioned(
            left: 10.w,
            top: 30.h,
            child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            bottom: 0.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              height: 370.h,
              width: double.infinity,
              padding: EdgeInsets.all(13.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
                //borderRadius: BorderRadius.circular(15.0),
              ),
              child: AuthForm(),
            ),
          ),
        ],
      ),
    );
  }
}
