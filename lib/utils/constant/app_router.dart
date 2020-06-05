import 'package:flutter/material.dart';

import '../../ui/main/main_tab_screen.dart';
import '../../ui/onboarding/login_screen.dart';
import '../../ui/onboarding/splash_screen.dart';

Map<String, WidgetBuilder> get AppRouter => {
      SplashScreenWidget.routerName: (ctx) => SplashScreenWidget(),
      MainTabScreen.routerName: (ctx) => MainTabScreen(),
      LoginScreenWidget.routerName: (ctx) => LoginScreenWidget(),
    };
