import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/model/place.dart';
import 'package:tembea_user/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverCarousel extends StatefulWidget {
  const SliverCarousel({Key key, @required this.place}) : super(key: key);
  final Places place;
  @override
  _SliverCarouselState createState() => _SliverCarouselState();
}

class _SliverCarouselState extends State<SliverCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.place.gallery.length,
          itemBuilder: (context, index) {
            String image = widget.place.gallery[index];
            return Container(
              height: 400.h,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.grey[350],
                  child: Container(),
                ),
              ),
            );
          },
          options: CarouselOptions(
              height: 400.h,
              initialPage: 0,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              scrollDirection: Axis.horizontal,
              pauseAutoPlayOnTouch: true,
              autoPlayCurve: Curves.easeIn),
        ),
        SizedBox(height: 7.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.place.gallery.length,
            (index) => Container(
              height: 7.h,
              width: _currentIndex == index ? 20.w : 7.w,
              margin: EdgeInsets.only(right: 5.w),
              decoration: BoxDecoration(
                color:
                    _currentIndex == index ? kDarkPrimaryColor : kPrimaryColor,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
