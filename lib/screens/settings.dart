import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tembea_user/utils/constants.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SwitchListTile.adaptive(
                inactiveThumbColor: kPrimaryColor,
                activeColor: kDarkPrimaryColor,
                title: Text(
                  'DarkMode',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                value: true,
                onChanged: (val) {},
              ),
              buildListTile(
                  onPress: () {},
                  label: 'Rate & Review',
                  icon: Icons.star_border),
              buildListTile(
                  onPress: () {}, label: 'Privacy Policy', icon: Icons.lock),
              buildListTile(
                  onPress: () {},
                  label: 'App Version',
                  icon: MdiIcons.alertDecagram),
              buildListTile(
                  icon: Icons.share, label: 'Invite friends', onPress: () {}),
              ListTile(
                title: Text(
                  'Contact',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                subtitle: Text(
                  'scraftke@gmail.com',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: Icon(Icons.email, color: kDarkPrimaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildListTile({Function onPress, String label, IconData icon}) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(16),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
      leading: Icon(icon, color: kDarkPrimaryColor),
      onTap: onPress,
      //subtitle: Text(subtitle),
    );
  }
}
