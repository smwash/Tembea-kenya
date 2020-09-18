import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/model/place.dart';
import 'package:tembea_user/screens/placeDetail.dart';
import 'package:tembea_user/utils/constants.dart';
import 'package:tembea_user/utils/pageAnimation.dart';
import '../../utils/stringCapitalizer.dart';

class PopularPlacesCard extends StatelessWidget {
  const PopularPlacesCard({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Places place;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
        tag: UniqueKey(),
        child: Container(
          height: 168.h,
          //padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: BoxDecoration(
            //color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Stack(
            children: [
              Container(
                height: 162.h,
                width: 120.w,
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                  //color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: place.coverPhoto,
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
              Positioned(
                right: 6.w,
                top: 5.5.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(2.0),
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
                right: 5.w,
                left: 5.w,
                child: Container(
                  width: 120.w,
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.0),
                  decoration: BoxDecoration(
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
