import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/model/place.dart';
import 'package:tembea_user/providers/placeProvider.dart';
import 'package:tembea_user/services/database.dart';
import 'package:tembea_user/widgets/homepage/popularPlacesCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      height: 168.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: places.getFanFavPlaces.length,
        itemBuilder: (context, index) {
          Places place = places.getFanFavPlaces[index];
          return PopularPlacesCard(place: place);
        },
      ),
    );
  }
}
