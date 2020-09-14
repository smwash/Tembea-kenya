import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tembea_user/services/authService.dart';
import 'package:tembea_user/utils/constants.dart';

import 'loginBtn.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 45.h),
          Text(
            'SignUp',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(23),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          SizedBox(height: 15.h),
          RoundIconNameBtn(
            label: 'facebook',
            icon: MdiIcons.facebook,
            onPress: () async {
              try {
                await AuthService().fbLogin();
                print('SignedIn');
              } catch (error) {
                print(error);
              }
            },
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  thickness: 2,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'OR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Divider(
                  color: kPrimaryColor,
                  thickness: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          RoundIconNameBtn(
            label: 'google',
            icon: MdiIcons.google,
            onPress: () async {
              try {
                await AuthService().googleSignIn();
                print('SignedIn');
              } catch (error) {
                print(error);
              }
            },
          ),
        ],
      ),
    );
  }
}
