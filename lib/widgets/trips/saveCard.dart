import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../model/place.dart';
import '../../screens/placeDetail.dart';
import '../../utils/constants.dart';
import '../../utils/pageAnimation.dart';
import '../../utils/stringCapitalizer.dart';

class SaveCard extends StatelessWidget {
  final Places place;

  const SaveCard({Key key, this.place}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 127.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.3),
              offset: Offset(0, 5),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: place.coverPhoto,
                height: 125.h,
                width: 160.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                    child: Container(
                      height: 120.h,
                      width: 200.w,
                    ),
                    baseColor: kShimmerBaseColor,
                    highlightColor: kShimmerHighlightColor),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              height: 120.h,
              width: 180.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name.toString().toLowerCase().capitalize(),
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 9.h),
                  Row(
                    children: [
                      SizedBox(width: 5.w),
                      Text(
                        '${place.likes.length} likes',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '${place.likes.length} Reviews',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: InkWell(
                      child: Text(
                        'Plan To Visit?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: kDarkPrimaryColor,
                        ),
                      ),
                      onTap: () {
                        //TODO navigate to plan Visit
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          PageAnimator(
            page: PlaceDetail(place: place),
          ),
        );
      },
    );
  }
}
