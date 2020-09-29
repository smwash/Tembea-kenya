import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/services/database.dart';
import '../../model/place.dart';
import '../../providers/placeProvider.dart';

import '../../utils/constants.dart';

class SecondRowUpper extends StatefulWidget {
  const SecondRowUpper({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Places place;

  @override
  _SecondRowUpperState createState() => _SecondRowUpperState();
}

class _SecondRowUpperState extends State<SecondRowUpper> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      PlaceProvider placeProvider =
          Provider.of<PlaceProvider>(context, listen: false);
      Database().getPlaceReviews(
          placeId: widget.place.placeId, placeProvider: placeProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite, color: kDarkPrimaryColor),
                SizedBox(width: 6.w),
                Text(
                  '${widget.place.likes.length} likes',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.message, color: kDarkPrimaryColor),
                SizedBox(width: 6.w),
                Consumer<PlaceProvider>(builder: (context, review, _) {
                  return Text(
                    '${review.getReviewList.length} reviews',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w600,
                    ),
                    //TODO add reviews.
                  );
                })
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(MdiIcons.mapMarkerDistance, color: kDarkPrimaryColor),
                SizedBox(width: 6.w),
                Text(
                  '${widget.place.distance}Km from Nairobi',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.access_time, color: kDarkPrimaryColor),
                SizedBox(width: 6.w),
                Text(
                  '${widget.place.time}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
