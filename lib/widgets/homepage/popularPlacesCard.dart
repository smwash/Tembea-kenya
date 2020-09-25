import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../model/place.dart';
import '../../screens/placeDetail.dart';
import '../../utils/constants.dart';
import '../../utils/pageAnimation.dart';
import '../../utils/stringCapitalizer.dart';

class PopularPlacesCard extends StatelessWidget {
  const PopularPlacesCard(
      {Key key, @required this.place, this.isFanFav = false})
      : super(key: key);

  final Places place;
  final bool isFanFav;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
        tag: UniqueKey(),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: place.coverPhoto,
                height: double.infinity,
                width: 130.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.grey[350],
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 170.h,
                      width: 120.w),
                ),
              ),
            ),
            if (isFanFav)
              Positioned(
                right: 3.w,
                top: 2.5.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: kDarkPrimaryColor),
                      SizedBox(width: 3.w),
                      Text(
                        '${place.likes.length}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              right: 0.w,
              left: 0.w,
              child: Container(
                width: 120.w,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.0),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(12)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
                alignment: Alignment.bottomLeft,
                child: Text(
                  '${place.name.toString().capitalize()}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(12.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
