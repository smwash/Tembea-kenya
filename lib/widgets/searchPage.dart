import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/screens/placeDetail.dart';
import 'package:tembea_user/utils/pageAnimation.dart';
import '../model/place.dart';
import '../providers/placeProvider.dart';
import '../utils/constants.dart';
import '../utils/stringCapitalizer.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: EdgeInsets.all(9.h),
        child: GestureDetector(
          child: CircleAvatar(
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.close, color: Colors.white),
          ),
          onTap: () {
            query = '';
          },
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(9.h),
      child: GestureDetector(
        child: CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final places = Provider.of<PlaceProvider>(context);
    final suggestionList = query.isEmpty
        ? places.getAllPlaces
        : places.getAllPlaces
            .where((place) =>
                place.name.toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        Places place = suggestionList[index];
        return InkWell(
          child: Container(
            height: 130.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.4),
                  offset: Offset(1, 7),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: place.coverPhoto,
                    height: 128.h,
                    width: 155.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 15.w),
                Container(
                  height: 125.h,
                  width: 200.w,
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name.toString().toLowerCase().capitalize(),
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Divider(
                        color: kDarkPrimaryColor,
                        thickness: 1.2,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          SizedBox(width: 5.w),
                          Text(
                            '${place.likes.length} likes',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 35.w),
                          Text(
                            '${place.likes.length} Reviews',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () => Navigator.push(
            context,
            PageAnimator(
              page: PlaceDetail(place: place),
            ),
          ),
        );
      },
    );
  }
}
