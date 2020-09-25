import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/place.dart';
import '../providers/placeProvider.dart';
import '../services/database.dart';
import '../shared/placeCatCard.dart';
import '../shared/categoryAppbar.dart';
import '../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarineParks extends StatefulWidget {
  @override
  _MarineParksState createState() => _MarineParksState();
}

class _MarineParksState extends State<MarineParks> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      PlaceProvider placeProvider =
          Provider.of<PlaceProvider>(context, listen: false);
      Database().getMarineParks(placeProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<PlaceProvider>(context);
    return Scaffold(
      appBar: categoryAppBar(context: context, title: 'Marine Parks'),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: places.getMarineParks.length,
        itemBuilder: (context, index) {
          Places place = places.getMarineParks[index];
          return Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h),
            child: PlaceCategoryCard(place: place),
          );
        },
      ),
    );
  }
}
