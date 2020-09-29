import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../model/place.dart';
import '../../model/review.dart';
import '../../providers/placeProvider.dart';
import '../../services/database.dart';
import '../../widgets/placeDetail/reviewCard.dart';

class PlaceReviews extends StatefulWidget {
  final Places place;

  const PlaceReviews({Key key, @required this.place}) : super(key: key);
  @override
  _PlaceReviewsState createState() => _PlaceReviewsState();
}

class _PlaceReviewsState extends State<PlaceReviews> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) {
      PlaceProvider placeProvider =
          Provider.of<PlaceProvider>(context, listen: false);
      Database().getPlaceReviews(
          placeId: widget.place.placeId, placeProvider: placeProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<PlaceProvider>(context);
    return places.getReviewList.length == 0
        ? Text(
            'No Reviews Yet',
            style: TextStyle(
              color: kDarkPrimaryColor,
              fontSize: ScreenUtil().setSp(17.5),
              fontWeight: FontWeight.w600,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: places.getReviewList.length,
            itemBuilder: (context, index) {
              Review review = places.getReviewList[index];
              return ReviewCard(review: review);
            },
          );
  }
}
