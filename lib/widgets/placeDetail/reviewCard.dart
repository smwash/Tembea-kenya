import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tembea_user/model/review.dart';
import 'package:tembea_user/utils/constants.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key key, @required this.review}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100.h,
      //width: double.infinity,
      //padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
      //color: Colors.blue,
      child: ListTile(
        tileColor: kPrimaryColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(review.userPhoto),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              review.name,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              DateFormat.yMMMd().format(review.dateCreated),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(13),
              ),
            ),
          ],
        ),
        subtitle: Text(
          review.review,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
