import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List<String> _carouselImages = [
  'assets/images/masaimaraWildbeast.jpg',
  'assets/images/lions.jpg',
  'assets/images/karuruFallsAberdare.jpg',
  'assets/images/maraBaloon.jpg',
  'assets/images/chyuluhills.jpg',
  'assets/images/nairobiNight.jpg',
];

class SignUpCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: _carouselImages.map(
        (image) {
          return Builder(
            builder: (context) {
              return Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitHeight,
                  ));
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
          height: double.infinity,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 1,
          autoPlayInterval: Duration(seconds: 3),
          scrollDirection: Axis.horizontal,
          pauseAutoPlayOnTouch: true,
          scrollPhysics: BouncingScrollPhysics(),
          autoPlayCurve: Curves.easeIn),
    );
  }
}
