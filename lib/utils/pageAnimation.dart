import 'package:flutter/cupertino.dart';

class PageAnimator extends PageRouteBuilder {
  final Widget page;
  PageAnimator({this.page})
      : super(
            transitionDuration: Duration(milliseconds: 200),
            transitionsBuilder: (context, Animation<double> animation,
                Animation<double> secAnimation, Widget child) {
              animation = CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              );
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (
              context,
              Animation<double> animation,
              Animation<double> secAnimation,
            ) =>
                page);
}

class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  EnterExitRoute({this.exitPage, this.enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );
}
