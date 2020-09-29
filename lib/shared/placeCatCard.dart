import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/providers/placeProvider.dart';
import 'package:tembea_user/services/database.dart';
import '../model/place.dart';
import '../screens/placeDetail.dart';
import '../utils/constants.dart';
import '../utils/pageAnimation.dart';
import '../utils/stringCapitalizer.dart';

class PlaceCategoryCard extends StatefulWidget {
  final Places place;

  const PlaceCategoryCard({Key key, @required this.place}) : super(key: key);

  @override
  _PlaceCategoryCardState createState() => _PlaceCategoryCardState();
}

class _PlaceCategoryCardState extends State<PlaceCategoryCard> {
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
    return GestureDetector(
      child: Container(
        height: 295.h,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.4),
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
                imageUrl: widget.place.coverPhoto,
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
                        widget.place.name.toString().toLowerCase().capitalize(),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    widget.place.description,
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
                          text: '${widget.place.likes.length} likes',
                          icon: Icons.favorite),
                      Consumer<PlaceProvider>(
                        builder: (context, reviews, _) {
                          return buildRow(
                            text: '${reviews.getReviewList.length} reviews',
                            icon: Icons.comment,
                          );
                        },
                      ),
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
          page: PlaceDetail(place: widget.place),
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
