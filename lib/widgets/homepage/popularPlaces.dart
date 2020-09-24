import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/place.dart';
import '../../providers/placeProvider.dart';
import '../../services/database.dart';

import 'popularPlacesCard.dart';

class PopularPlaces extends StatefulWidget {
  @override
  _PopularPlacesState createState() => _PopularPlacesState();
}

class _PopularPlacesState extends State<PopularPlaces> {
  @override
  void initState() {
    super.initState();
    PlaceProvider places = Provider.of<PlaceProvider>(context, listen: false);
    Database().getfanFavPlaces(places);
  }

  @override
  Widget build(BuildContext context) {
    PlaceProvider places = Provider.of<PlaceProvider>(context);
    return Container(
      height: 170.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: places.getFanFavPlaces.length,
        itemBuilder: (context, index) {
          Places place = places.getFanFavPlaces[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: PopularPlacesCard(place: place, isFanFav: true),
          );
        },
      ),
    );
  }
}
