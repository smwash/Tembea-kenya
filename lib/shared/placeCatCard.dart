import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../model/place.dart';
import '../screens/placeDetail.dart';
import '../utils/constants.dart';
import '../utils/pageAnimation.dart';
import '../utils/stringCapitalizer.dart';

class PlaceCategoryCard extends StatelessWidget {
  final Places place;

  const PlaceCategoryCard({Key key, @required this.place}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 295.h,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: place.coverPhoto,
                height: 182.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                    child: Container(height: 150.h, width: double.infinity),
                    baseColor: kShimmerBaseColor,
                    highlightColor: kShimmerHighlightColor),
              ),
            ),
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: kDarkPrimaryColor),
                      Text(
                        place.name.toString().toLowerCase().capitalize(),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    place.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildRow(
                          text: '${place.likes.length} likes',
                          icon: Icons.favorite),
                      buildRow(text: '4 reviews', icon: Icons.comment),
                    ],
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        PageAnimator(
          page: PlaceDetail(place: place),
        ),
      ),
    );
  }

  Row buildRow({String text, IconData icon}) {
    return Row(
      children: [
        Icon(icon, color: kPrimaryColor),
        SizedBox(width: 10.w),
        Text(
          text,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
