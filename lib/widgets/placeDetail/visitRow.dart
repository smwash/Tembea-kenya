import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/screens/writeReview.dart';
import 'package:tembea_user/utils/pageAnimation.dart';
import '../../model/user.dart';
import '../../providers/placeProvider.dart';
import '../../services/database.dart';
import '../../model/place.dart';
import '../../utils/constants.dart';

class VisitRow extends StatefulWidget {
  const VisitRow({Key key, this.place}) : super(key: key);
  final Places place;

  @override
  _VisitRowState createState() => _VisitRowState();
}

class _VisitRowState extends State<VisitRow> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      UserData user = Provider.of<UserData>(context, listen: false);
      PlaceProvider placeProvider =
          Provider.of<PlaceProvider>(context, listen: false);
      Database().updateUserVisits(
          placeId: widget.place.placeId,
          userId: user.userId,
          placeProvider: placeProvider);
    });
  }

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
              Consumer<PlaceProvider>(
                builder: (context, visit, _) {
                  return InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: Color(0xfffadcac),
                          borderRadius: BorderRadius.circular(7)),
                      child: Row(
                        children: [
                          if (visit.isVisited)
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
                    onTap: () {
                      final user =
                          Provider.of<UserData>(context, listen: false);
                      try {
                        visit.updateVisitStatus(
                            userId: user.userId, placeId: widget.place.placeId);
                      } catch (error) {
                        print(error);
                      }
                    },
                  );
                },
              ),
              SizedBox(width: 20.w),
              InkWell(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: kDarkAccentColor,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text(
                    'Plan To Visit?',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // onTap: () => Navigator.push(
                //   context,
                //   PageAnimator(
                //     page: ReviewPage(),
                //   ),
                // ),
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
          onTap: () => Navigator.push(
            context,
            PageAnimator(
              page: ReviewPage(placeId: widget.place.placeId),
            ),
          ),
        ),
      ],
    );
  }
}
