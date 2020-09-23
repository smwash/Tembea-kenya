import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/screens/placeDetail.dart';
import 'package:tembea_user/utils/constants.dart';
import 'package:tembea_user/utils/pageAnimation.dart';
import '../../providers/placeProvider.dart';
import '../../services/database.dart';

import 'featuredPlaceDetail.dart';

class FeaturedPlaces extends StatefulWidget {
  @override
  _FeaturedPlacesState createState() => _FeaturedPlacesState();
}

class _FeaturedPlacesState extends State<FeaturedPlaces> {
  @override
  void initState() {
    super.initState();
    PlaceProvider places = Provider.of<PlaceProvider>(context, listen: false);
    Database().getFeaturedPlaces(places);
  }

  @override
  Widget build(BuildContext context) {
    return buildStreamBuilder();
  }

  buildStreamBuilder() {
    PlaceProvider places = Provider.of<PlaceProvider>(context);
    return CarouselSlider(
      items: places.getFeaturedPlaces.map(
        (place) {
          return Builder(
            builder: (context) {
              return Stack(
                children: [
                  InkWell(
                      child: Container(
                          height: 200.h,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: place.coverPhoto,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: kShimmerBaseColor,
                              highlightColor: kShimmerHighlightColor,
                              child: Container(
                                height: 200.h,
                                width: double.infinity,
                              ),
                            ),
                          )),
                      onTap: () => Navigator.push(
                            context,
                            PageAnimator(
                              page: PlaceDetail(place: place),
                            ),
                          )),
                  // Positioned(
                  //   bottom: 0.h,
                  //   left: 0.w,
                  //   right: 0.w,
                  //   child: FeaturedPlaceDetail(place: place),
                  // ),
                ],
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
          height: 215.h,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 1,
          autoPlayInterval: Duration(seconds: 5),
          scrollDirection: Axis.horizontal,
          pauseAutoPlayOnTouch: true,
          scrollPhysics: BouncingScrollPhysics(),
          autoPlayCurve: Curves.easeIn),
    );
  }
}
