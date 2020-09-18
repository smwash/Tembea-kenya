import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/providers/placeProvider.dart';
import 'package:tembea_user/screens/placeDetail.dart';
import 'package:tembea_user/services/database.dart';
import 'package:tembea_user/utils/constants.dart';
import '../../utils/stringCapitalizer.dart';
import 'package:tembea_user/model/place.dart';

class AllPlaces extends StatefulWidget {
  @override
  _AllPlacesState createState() => _AllPlacesState();
}

class _AllPlacesState extends State<AllPlaces> {
  @override
  void initState() {
    super.initState();
    PlaceProvider places = Provider.of<PlaceProvider>(context, listen: false);
    Database().getAllPlaces(places);
  }

  @override
  Widget build(BuildContext context) {
    PlaceProvider places = Provider.of<PlaceProvider>(context);

    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: places.getAllPlaces.length,
        itemBuilder: (context, index) {
          var place = places.getAllPlaces[index];

          return InkWell(
            child: Container(
              height: 265.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: place.coverPhoto,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, color: kDarkPrimaryColor),
                              SizedBox(width: 10.w),
                              Text(
                                place.name
                                    .toString()
                                    .toLowerCase()
                                    .capitalize(),
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15.5),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.favorite,
                                      color: kDarkPrimaryColor),
                                  SizedBox(width: 7.w),
                                  Text(
                                    '${place.likes.length} likes',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 30.w),
                              Row(
                                children: [
                                  Icon(Icons.message, color: kDarkPrimaryColor),
                                  SizedBox(width: 7.w),
                                  Text(
                                    '8 reviews',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    //TODO add reviews.
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaceDetail(place: place)),
              );
            },
          );
        });
  }
}
