import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tembea_user/utils/constants.dart';

class VisitRow extends StatelessWidget {
  const VisitRow({Key key, this.place}) : super(key: key);
  final QueryDocumentSnapshot place;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(children: [
              Text('–',
                  style: TextStyle(
                      color: kDarkPrimaryColor,
                      fontSize: ScreenUtil().setSp(25),
                      fontWeight: FontWeight.w700)),
              Text(' Ever Visited?',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 20.w),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: Color(0xfffadcac),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    children: [
                      Icon(Icons.check, color: kDarkPrimaryColor),
                      SizedBox(width: 5.w),
                      Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(width: 20.w),
              InkWell(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: Color(0xfffadcac),
                      borderRadius: BorderRadius.circular(7)),
                  child: Text(
                    'Plan To Visit?',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () {},
              )
            ]),
          ],
        ),
        SizedBox(height: 10.h),
        InkWell(
          child: Row(
            children: [
              Icon(MdiIcons.fileDocumentEditOutline, color: kDarkPrimaryColor),
              SizedBox(width: 6.w),
              Text(
                'Write a review',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
