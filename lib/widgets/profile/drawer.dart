import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/screens/authScreen.dart';
import 'package:tembea_user/utils/pageAnimation.dart';
import '../../providers/themeProvider.dart';
import '../../services/authService.dart';
import '../../utils/constants.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<ThemeProvider>(
                builder: (context, theme, _) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 7.w),
                    leading: Icon(theme.isDarkMode
                        ? Icons.brightness_4
                        : Icons.brightness_7),
                    title: Text(
                      'DarkMode',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    trailing: Switch(
                        value: theme.isDarkMode,
                        onChanged: (value) => theme.setDarkMode(value)),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 7.w),
                title: Text(
                  'LogOut',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                trailing: Icon(Icons.logout,
                    size: ScreenUtil().setSp(25), color: kDarkPrimaryColor),
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    PageAnimator(
                      page: AuthScreen(),
                    ),
                  );
                  await AuthService().logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
