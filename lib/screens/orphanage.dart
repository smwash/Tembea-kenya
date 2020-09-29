import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/place.dart';
import '../providers/placeProvider.dart';
import '../services/database.dart';
import '../shared/placeCatCard.dart';
import '../shared/categoryAppbar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Orphanage extends StatefulWidget {
  @override
  _OrphanageState createState() => _OrphanageState();
}

class _OrphanageState extends State<Orphanage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      PlaceProvider placeProvider =
          Provider.of<PlaceProvider>(context, listen: false);
      Database().getOrphanage(placeProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<PlaceProvider>(context);
    return Scaffold(
      appBar: categoryAppBar(context: context, title: 'Orphanage Parks'),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: places.getOrphanage.length,
        itemBuilder: (context, index) {
          Places place = places.getOrphanage[index];
          return Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 12.h),
            child: PlaceCategoryCard(place: place),
          );
        },
      ),
    );
  }
}
