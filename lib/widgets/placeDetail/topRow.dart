import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/model/place.dart';
import 'package:tembea_user/model/user.dart';
import 'package:tembea_user/providers/user.dart';
import 'package:tembea_user/services/database.dart';
import 'package:tembea_user/utils/constants.dart';
import '../../utils/stringCapitalizer.dart';

class PlaceDetailTopRow extends StatefulWidget {
  const PlaceDetailTopRow({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Places place;

  @override
  _PlaceDetailTopRowState createState() => _PlaceDetailTopRowState();
}

class _PlaceDetailTopRowState extends State<PlaceDetailTopRow> {
  bool _isLiked = false;

  bool _isSaved = false;

  // @override
  // void initState() {
  //   super.initState();
  //   UserData user = Provider.of<UserData>(context, listen: false);
  //   UserProvider userProvider =
  //       Provider.of<UserProvider>(context, listen: false);
  //   Database().updateSavedStatus(userId: user.userId, placeId: widget.place.placeId, userProvider: userProvider);
  // }

  // _handleSavedStatus() async {
  //   var savedPlace = Database().querySavedPlaces(widget.place.id);
  //   if (savedPlace == null) {
  //     setState(() => _isSaved = false);
  //   } else if (savedPlace != null) {
  //     setState(() => _isSaved = true);
  //   }
  // }

  // _handleSavePlace() async {
  //   final user = Provider.of<UserData>(context, listen: false);
  //   try {
  //     if (_isSaved) {
  //       await Database()
  //           .removeFromSavedPlaces(userId: user.userId, id: widget.place.id);
  //       setState(() => _isSaved = false);
  //       //print('${widget.place.id} removed');
  //     } else if (!_isSaved) {
  //       await Database()
  //           .addToSavedPlaces(userId: user.userId, id: widget.place.id);
  //       setState(() => _isSaved = true);
  //       //print('${widget.place.id} added');
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  // handleLikePost() async {
  //   final user = Provider.of<UserData>(context, listen: false);
  //   bool isLiked = await widget.place.get('likes')[user.userId] == true;

  //   if (isLiked) {
  //     await widget.place.reference.update({'likes.${user.userId}': false});

  //     setState(() {
  //       _isLiked = false;
  //       widget.place.get('likes')[user.userId] = false;
  //     });
  //   } else if (!isLiked) {
  //     await widget.place.reference.update({'likes.${user.userId}': true});

  //     setState(() {
  //       _isLiked = true;
  //       widget.place.get('likes')[user.userId] = true;
  //       //showHeart = true;
  //     });
  //     // Timer(Duration(milliseconds: 500), () {
  //     //   setState(() {
  //     //     showHeart = false;
  //     //   });
  //     // });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserData>(context);
    //_isLiked = (widget.place.get('likes')[user.userId] == true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, color: kDarkPrimaryColor),
            Text(
              widget.place.name.toString().toLowerCase().capitalize(),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Consumer<UserProvider>(builder: (context, status, _) {
          return Row(
            children: [
              IconButton(
                icon: _isLiked
                    ? Icon(Icons.favorite,
                        color: Colors.amber, size: ScreenUtil().setSp(25))
                    : Icon(Icons.favorite_border, size: ScreenUtil().setSp(25)),
                // onPressed: () async {
                //   UserData user = Provider.of<UserData>(context);
                //   try {
                //     status.updateSavedStatus(
                //         userId: user.userId, placeId: widget.place.placeId);
                //   } catch (error) {
                //     print(error);
                //   }
                // }),
              ),
              InkWell(
                child: CircleAvatar(
                  backgroundColor: kDarkPrimaryColor,
                  child: status.savedStatus
                      ? Icon(Icons.bookmark, color: Colors.white)
                      : Icon(Icons.bookmark_border, color: Colors.white),
                ),
                onTap: () async {
                  UserData user = Provider.of<UserData>(context, listen: false);
                  try {
                    status.updateSavedStatus(
                        userId: user.userId, placeId: widget.place.placeId);
                  } catch (error) {
                    print(error);
                  }
                },
              ),
            ],
          );
        }),
      ],
    );
  }
}
