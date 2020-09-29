import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/homepage.dart';
import '../screens/profile.dart';

import '../screens/trips.dart';
import '../utils/constants.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 400.0, height: 810.0, allowFontScaling: true);
    List<Widget> _pages = [
      HomePage(),
      Trips(),
      Profile(),
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Material(
          elevation: 2.0,
          child: TabBar(
            labelColor: kDarkPrimaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: kDarkPrimaryColor,
            unselectedLabelColor: kPrimaryColor.withOpacity(0.8),
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(color: kDarkPrimaryColor, width: 4),
              ),
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.explore, size: ScreenUtil().setSp(29)),
              ),
              Tab(
                icon: Icon(Icons.favorite, size: ScreenUtil().setSp(29)),
              ),
              Tab(
                icon: Icon(Icons.person, size: ScreenUtil().setSp(29)),
              ),
            ],
          ),
        ),
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(), children: _pages),
      ),
    );
  }
}
