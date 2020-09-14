import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tembea_user/utils/constants.dart';

class PlaceDetailDescription extends StatefulWidget {
  final QueryDocumentSnapshot place;

  const PlaceDetailDescription({Key key, @required this.place})
      : super(key: key);
  @override
  _PlaceDetailDescriptionState createState() => _PlaceDetailDescriptionState();
}

class _PlaceDetailDescriptionState extends State<PlaceDetailDescription> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: Text(
            widget.place.get('description'),
            maxLines: 5,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(13),
              fontWeight: FontWeight.w500,
              wordSpacing: 1.2,
              height: 1.1,
            ),
          ),
          secondChild: Text(
            widget.place.get('description'),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(13.7),
              fontWeight: FontWeight.w500,
              wordSpacing: 1.2,
              height: 1.2,
            ),
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: kThemeAnimationDuration,
        ),
        GestureDetector(
            child: Text(
              _isExpanded ? 'Less...' : 'More...',
              style: TextStyle(
                color: kDarkPrimaryColor,
                fontSize: ScreenUtil().setSp(13.7),
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              setState(() => _isExpanded = !_isExpanded);
            }),
      ],
    );
  }
}
