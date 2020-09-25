import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 7.w),
                title: Text(
                  'DarkMode',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                trailing: Icon(Icons.brightness_6),
                onTap: () => Provider.of<ThemeProvider>(context, listen: false)
                    .setTheme(),
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
