import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tembea_user/services/database.dart';
import 'package:tembea_user/utils/constants.dart';
import '../../utils/stringCapitalizer.dart';

class PlaceDetailTopRow extends StatefulWidget {
  const PlaceDetailTopRow({
    Key key,
    @required this.place,
  }) : super(key: key);

  final QueryDocumentSnapshot place;

  @override
  _PlaceDetailTopRowState createState() => _PlaceDetailTopRowState();
}

class _PlaceDetailTopRowState extends State<PlaceDetailTopRow> {
  bool _isLiked = false;
  int _likes;

  _handlePlaceLike() async {
    int likes = widget.place.get('likes');
    if (_isLiked) {
      setState(() {
        //_isLiked = true;
        widget.place.reference.update({'likes': likes++});
      });
    } else {
      setState(() {
        //_isLiked = false;
        widget.place.reference.update({'likes': likes--});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //int likes = widget.place.get('likes');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, color: kDarkPrimaryColor),
            Text(
              widget.place.get('name').toString().toLowerCase().capitalize(),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                icon: _isLiked
                    ? Icon(Icons.favorite,
                        color: Colors.amber, size: ScreenUtil().setSp(25))
                    : Icon(Icons.favorite_border, size: ScreenUtil().setSp(25)),
                onPressed: () async {
                  try {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                    await _handlePlaceLike();
                  } catch (error) {
                    print(error);
                  }
                }),
            InkWell(
              child: CircleAvatar(
                backgroundColor: kDarkPrimaryColor,
                child: Icon(Icons.bookmark_border),
              ),
              onTap: () async {
                await Database().updateData(widget.place.id);
              },
            ),
          ],
        ),
      ],
    );
  }
}
