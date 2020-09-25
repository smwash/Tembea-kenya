import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/widgets/profile/drawer.dart';

import '.././model/user.dart';
import '.././providers/user.dart';
import '.././services/authService.dart';
import '.././services/database.dart';
import '.././utils/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserData>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    Database().getUserData(user: user, userProvider: userProvider);
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userdata = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.h),
            child: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.settings, color: Colors.white),
                ),
                onTap: _openEndDrawer),
          ),
        ],
      ),
      endDrawer: SettingsDrawer(),
      endDrawerEnableOpenDragGesture: true,
      body: userdata == null
          ? SizedBox.shrink()
          : Container(
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
                        title: 'Member Since',
                        icon: MdiIcons.calendarRange,
                        label:
                            '${DateFormat().add_yMMMd().format(userdata.memberSince)}'),
                    SizedBox(height: 3.h),
                    Divider(color: kPrimaryColor),
                    buildListTile(
                        icon: Icons.share,
                        label: 'Invite friends',
                        onPress: () {}),
                    Divider(color: kPrimaryColor),
                    buildListTile(
                        onPress: () {},
                        label: 'Rate & Review',
                        icon: Icons.star_border),
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

  ListTile buildListTile({Function onPress, String label, IconData icon}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 7.w),
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
