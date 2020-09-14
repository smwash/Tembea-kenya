import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tembea_user/utils/constants.dart';
import 'package:tembea_user/widgets/authform/authForm.dart';

class AuthScreen extends StatelessWidget {
  @override
  // List<String> carouselImages = [
  //   'assets/images/lions.jpg',
  //   'assets/images/maraBaloon.jpg',
  //   'assets/images/leopards.jpg',
  // ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/chyuluhills.jpg',
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10.w,
              top: 10.h,
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
                height: 350.h,
                width: double.infinity,
                padding: EdgeInsets.all(13.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
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
      ),
    );
  }
}
