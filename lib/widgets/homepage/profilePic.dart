import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/model/user.dart';
import 'package:tembea_user/screens/profile.dart';
import 'package:tembea_user/utils/pageAnimation.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData user = Provider.of<UserData>(context);
    return IconButton(
      iconSize: ScreenUtil().setSp(24),
      icon: ClipOval(
        //radius: ScreenUtil().setSp(24),
        child: CachedNetworkImage(imageUrl: user.photoUrl),
      ),
      onPressed: () => Navigator.push(
        context,
        PageAnimator(
          page: Profile(),
        ),
      ),
    );
  }
}
