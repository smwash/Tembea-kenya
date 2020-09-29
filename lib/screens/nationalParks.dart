import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../shared/placeCatCard.dart';
import '../model/place.dart';
import '../providers/placeProvider.dart';
import '../services/database.dart';
import '../shared/categoryAppbar.dart';

class NationalParks extends StatefulWidget {
  @override
  _NationalParksState createState() => _NationalParksState();
}

class _NationalParksState extends State<NationalParks> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      PlaceProvider placeProvider =
          Provider.of<PlaceProvider>(context, listen: false);
      Database().getNationalParks(placeProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<PlaceProvider>(context);
    return Scaffold(
      appBar: categoryAppBar(context: context, title: 'National Parks'),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: places.getNationalParks.length,
        itemBuilder: (context, index) {
          Places place = places.getNationalParks[index];
          return Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h),
            child: PlaceCategoryCard(place: place),
          );
        },
      ),
    );
  }
}
