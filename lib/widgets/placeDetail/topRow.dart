import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../model/place.dart';
import '../../model/user.dart';
import '../../providers/user.dart';
import '../../services/database.dart';
import '../../utils/constants.dart';
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
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) {
      UserData user = Provider.of<UserData>(context, listen: false);
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      Database().updateUserSaveStatus(
          userId: user.userId,
          placeId: widget.place.placeId,
          userProvider: userProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      : Icon(Icons.favorite_border,
                          size: ScreenUtil().setSp(25)),
                  onPressed: () {}),
              GestureDetector(
                child: CircleAvatar(
                  backgroundColor: kDarkPrimaryColor,
                  child: status.savedStatus
                      ? Icon(Icons.bookmark, color: Colors.white)
                      : Icon(Icons.bookmark_border, color: Colors.white),
                ),
                onTap: () async {
                  UserData user = Provider.of<UserData>(context, listen: false);
                  try {
                    status.updateLocalSaveStatus(
                        userId: user.userId, placeId: widget.place.placeId);
                    print('executed');
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
