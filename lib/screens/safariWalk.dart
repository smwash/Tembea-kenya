import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/place.dart';
import '../providers/placeProvider.dart';
import '../services/database.dart';
import '../shared/placeCatCard.dart';
import '../shared/categoryAppbar.dart';

class SafariWalk extends StatefulWidget {
  @override
  _SafariWalkState createState() => _SafariWalkState();
}

class _SafariWalkState extends State<SafariWalk> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      PlaceProvider placeProvider =
          Provider.of<PlaceProvider>(context, listen: false);
      Database().getSafariWalk(placeProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<PlaceProvider>(context);
    return Scaffold(
      appBar: categoryAppBar(context: context, title: 'SafariWalk'),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: places.getSafariwalk.length,
        itemBuilder: (context, index) {
          Places place = places.getSafariwalk[index];
          return Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 12.h),
            child: PlaceCategoryCard(place: place),
          );
        },
      ),
    );
  }
}
