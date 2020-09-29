import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tembea_user/utils/constants.dart';
import '../../shared/categoryCard.dart';
import '../../screens/hotel.dart';
import '../../screens/marineParks.dart';
import '../../screens/nationalParks.dart';
import '../../screens/orphanage.dart';
import '../../screens/safariWalk.dart';
import '../../utils/pageAnimation.dart';
import 'kwsfeesPage.dart';

class PlaceCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5.w),
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.category),
                    SizedBox(width: 8.w),
                    Row(
                      children: [
                        Text(
                          'Place Category',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'KWS Park entry fee',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(13.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.push(
                      context, PageAnimator(page: KwsEntryFeesPg())),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  CategoryCard(
                    text: 'National Parks',
                    icon: MdiIcons.elephant,
                    press: () => Navigator.push(
                      context,
                      PageAnimator(
                        page: NationalParks(),
                      ),
                    ),
                  ),
                  CategoryCard(
                    text: 'Marine Parks',
                    icon: MdiIcons.skiWater,
                    press: () => Navigator.push(
                      context,
                      PageAnimator(
                        page: MarineParks(),
                      ),
                    ),
                  ),
                  CategoryCard(
                    text: 'Orphanage',
                    icon: MdiIcons.homeAssistant,
                    press: () => Navigator.push(
                      context,
                      PageAnimator(page: Orphanage()),
                    ),
                  ),
                  CategoryCard(
                    text: 'Safari Walk',
                    icon: Icons.directions_walk,
                    press: () => Navigator.push(
                      context,
                      PageAnimator(
                        page: SafariWalk(),
                      ),
                    ),
                  ),
                  CategoryCard(
                    text: 'Hotels',
                    icon: Icons.hotel,
                    press: () => Navigator.push(
                      context,
                      PageAnimator(
                        page: Hotels(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
