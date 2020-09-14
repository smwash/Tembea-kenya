import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/utils/constants.dart';

import 'featuredPlaceDetail.dart';

class FeaturedPlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('places')
            .limit(4)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.hasError) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[200],
              highlightColor: Colors.grey[350],
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                height: 160.h,
                //width: double.infinity,
              ),
            );
          }
          return CarouselSlider(
            items: snapshot.data.docs.map(
              (place) {
                return Builder(
                  builder: (context) {
                    return Stack(
                      children: [
                        InkWell(
                          child: Container(
                              height: 155.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: CachedNetworkImage(
                                  imageUrl: place.get('coverPhoto'),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[200],
                                    highlightColor: Colors.grey[350],
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 10.h),
                                      height: 160.h,
                                      //width: double.infinity,
                                    ),
                                  ),
                                ),
                              )),
                          onTap: () {},
                        ),
                        Positioned(
                          bottom: 3.h,
                          left: 50.w,
                          right: 50.w,
                          child: FeaturedPlaceDetail(place: place),
                        ),
                      ],
                    );
                  },
                );
              },
            ).toList(),
            options: CarouselOptions(
                height: 200.h,
                initialPage: 0,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 0.89,
                //disableCenter: true,
                autoPlayInterval: Duration(seconds: 5),
                scrollDirection: Axis.horizontal,
                pauseAutoPlayOnTouch: true,
                scrollPhysics: BouncingScrollPhysics(),
                autoPlayCurve: Curves.easeIn),
          );
        });
  }
}
