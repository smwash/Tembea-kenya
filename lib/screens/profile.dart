import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/model/user.dart';
import 'package:tembea_user/providers/user.dart';
import 'package:tembea_user/services/authService.dart';
import 'package:tembea_user/services/database.dart';
import 'package:tembea_user/utils/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserData>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    Database().getUserData(user: user, userProvider: userProvider);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userdata = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: kScaffoldBg,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Profile',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setSp(5)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: ScreenUtil().setSp(40),
                    backgroundColor: kPrimaryColor,
                    backgroundImage:
                        CachedNetworkImageProvider(userdata.userPhoto),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              buildColumn(
                  title: 'UserName',
                  icon: Icons.alternate_email,
                  label: userdata.userName),
              SizedBox(height: 5.h),
              Divider(color: kPrimaryColor),
              buildColumn(
                  title: 'Rank',
                  icon: MdiIcons.accountGroup,
                  label: '25 of 50'),
              SizedBox(height: 5.h),
              Divider(color: kPrimaryColor),
              buildColumn(
                  title: 'Member Since',
                  icon: MdiIcons.calendarRange,
                  label:
                      '${DateFormat().add_yMMMd().format(userdata.memberSince)}'),
              SizedBox(height: 5.h),
              Divider(color: kPrimaryColor),
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

  Column buildColumn({String title, String label, IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 9.h),
        Row(
          children: [
            Icon(icon, color: kDarkPrimaryColor),
            SizedBox(width: 15.w),
            Text(
              label,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(14.5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
      ],
    );
  }
}
