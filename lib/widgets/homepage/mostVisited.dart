import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/place.dart';
import '../../providers/placeProvider.dart';
import '../../services/database.dart';
import '../../widgets/homepage/popularPlacesCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostVisitedPlaces extends StatefulWidget {
  @override
  _MostVisitedPlacesState createState() => _MostVisitedPlacesState();
}

class _MostVisitedPlacesState extends State<MostVisitedPlaces> {
  @override
  void initState() {
    super.initState();
    PlaceProvider places = Provider.of<PlaceProvider>(context, listen: false);
    Database().getMostVisitedPlaces(places);
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
        itemCount: places.getmostVisitedPlaces.length,
        itemBuilder: (context, index) {
          Places place = places.getmostVisitedPlaces[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: PopularPlacesCard(place: place),
          );
        },
      ),
    );
  }
}
