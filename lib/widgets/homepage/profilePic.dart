import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../screens/profile.dart';
import '../../utils/pageAnimation.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData user = Provider.of<UserData>(context);
    return user == null
        ? SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: GestureDetector(
              child: CircleAvatar(
                radius: ScreenUtil().setSp(20),
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              onTap: () => Navigator.push(
                context,
                PageAnimator(
                  page: Profile(),
                ),
              ),
            ),
          );
  }
}
