import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tembea_user/model/review.dart';
import 'package:tembea_user/model/user.dart';
import 'package:tembea_user/services/database.dart';
import 'package:tembea_user/shared/categoryAppbar.dart';
import 'package:tembea_user/utils/constants.dart';

class ReviewPage extends StatefulWidget {
  final String placeId;

  const ReviewPage({Key key, @required this.placeId}) : super(key: key);
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _formKey = GlobalKey<FormState>();
  String _review;

  _handleSubmit() async {
    FocusScope.of(context).unfocus();
    UserData user = Provider.of<UserData>(context, listen: false);
    final isValid = _formKey.currentState.validate();
    try {
      if (isValid) {
        _formKey.currentState.save();
        Review review = Review(
          name: user.userName,
          userPhoto: user.photoUrl,
          userId: user.userId,
          placeId: widget.placeId,
          review: _review,
          reviewId: user.userId,
          dateCreated: DateTime.now(),
        );
        await Database()
            .addPlaceReview(placeId: widget.placeId, review: review);
        print('review added');
        Navigator.pop(context);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: categoryAppBar(context: context, title: 'Review'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    maxLines: null,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Review',
                      hintStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    enableSuggestions: true,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'A review can\`t be empty';
                      } else if (value.length < 3) {
                        return 'review should be atleast 3 charaters';
                      }
                      return null;
                    },
                    onSaved: (value) => _review = value,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 50.h,
              width: double.infinity,
              color: kPrimaryColor,
              alignment: Alignment.center,
              child: Text(
                'Submit',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(17),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ),
            onTap: _handleSubmit,
          ),
        ],
      ),
    );
  }
}
