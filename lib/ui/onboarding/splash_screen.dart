import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/ui/onboarding/login_screen.dart';
import 'package:samapp/ui/widget/footer_app_version.dart';

class SplashScreenWidget extends StatefulWidget {
  static const routerName = '/splash-screen/';

  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _navigateLoginScreen(context);
    });
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginScreenWidget.routerName);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: screenHeight - appBar.preferredSize.height,
        width: screenWidth,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (ctx, state) {
                if (state.connectionState == ConnectionState.done) {
                  _controller.forward();
                  return FadeTransition(
                    opacity: _animation,
                    child: Container(
                      width: screenWidth / 1.8,
                      height: screenWidth / 1.8,
                      margin: EdgeInsets.only(top: 74),
                      child: Image.asset('assets/images/logo_splash.png'),
                    ),
                  );
                } else {
                  return Container(
                    width: screenWidth / 1.8,
                    height: screenWidth / 1.8,
                    margin: EdgeInsets.only(top: 74),
                    child: SizedBox(),
                  );
                }
              },
            ),
            FooterAppVersion(S.of(context).common_app_version('1.0.0 Dev'))
          ],
        ),
      ),
    );
  }
}
