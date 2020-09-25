import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/providers/placeProvider.dart';
import 'package:tembea_user/widgets/searchPage.dart';
import '../../services/database.dart';
import '../../utils/constants.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  void initState() {
    super.initState();
    PlaceProvider places = Provider.of<PlaceProvider>(context, listen: false);
    Database().getAllPlaces(places);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 280.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      //margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: kDarkPrimaryColor, width: 1.5),
      ),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search location..',
          suffixIcon: GestureDetector(
            child: Container(
              height: 30.h,
              width: 30.w,
              margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Icon(Icons.search),
            ),
            // onTap: () async {
            //   await Database().updateData();
            // },
          ),
        ),
        onTap: () {
          showSearch(context: context, delegate: Search(ctx: context));
        },
      ),
    );
  }
}
