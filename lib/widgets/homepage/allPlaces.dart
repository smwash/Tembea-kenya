import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tembea_user/screens/placeDetail.dart';
import 'package:tembea_user/utils/constants.dart';
import '../../utils/stringCapitalizer.dart';

class AllPlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('places').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot place = snapshot.data.docs[index];

                return InkWell(
                  child: Container(
                    height: 265.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
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
                                imageUrl: place.get('coverPhoto'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: kDarkPrimaryColor),
                                    SizedBox(width: 10.w),
                                    Text(
                                      place
                                          .get('name')
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.favorite,
                                            color: kDarkPrimaryColor),
                                        SizedBox(width: 7.w),
                                        Text(
                                          '${place.get('likes')} likes',
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
                                        Icon(Icons.message,
                                            color: kDarkPrimaryColor),
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
        } else {
          return Container(
            height: 180.h,
            child: Shimmer.fromColors(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 180.h,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    );
                  },
                ),
                baseColor: Colors.orange,
                highlightColor: kPrimaryColor),
          );
        }
      },
    );
  }
}
