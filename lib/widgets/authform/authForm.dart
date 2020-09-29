import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../utils/connectivityEnums.dart';
import '../../widgets/authform/errorDialog.dart';
import '../../model/user.dart';
import '../../services/authService.dart';
import '../../utils/constants.dart';
import '../../utils/pageAnimation.dart';

import '../bottomNav.dart';
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
            label: 'Google',
            icon: MdiIcons.google,
            color: Colors.white,
            colorText: Colors.black,
            iconColor: Colors.black,
            onPress: () async {
              var netStatus =
                  Provider.of<ConnectivityStatus>(context, listen: false);

              try {
                if (netStatus == ConnectivityStatus.Wifi ||
                    netStatus == ConnectivityStatus.Cellular) {
                  await AuthService().googleSignIn();
                  if (AuthService().user != null) {
                    print('logged in');
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      PageAnimator(
                        page: BottomNav(),
                      ),
                    );
                  } else
                    return null;
                } else if (netStatus == ConnectivityStatus.Offline) {
                  return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ErrorDialog();
                    },
                  );
                }
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
            label: 'Facebook',
            color: Color(0xff3b5998),
            colorText: Colors.white,
            icon: MdiIcons.facebook,
            iconColor: Colors.white,
            onPress: () async {
              var netStatus =
                  Provider.of<ConnectivityStatus>(context, listen: false);

              try {
                if (netStatus == ConnectivityStatus.Wifi ||
                    netStatus == ConnectivityStatus.Cellular) {
                  await AuthService().fbLogin();
                  if (AuthService().user != null) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      PageAnimator(
                        page: BottomNav(),
                      ),
                    );
                  } else
                    return null;
                } else
                  ErrorDialog();

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
