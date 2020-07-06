import 'package:flutter/material.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/ui/chat/chat_screen.dart';

import '../../ui/main/main_tab_screen.dart';
import '../../ui/onboarding/login_screen.dart';
import '../../ui/onboarding/splash_screen.dart';

Map<String, WidgetBuilder> get AppRouter => {
      SplashScreenWidget.routerName: (ctx) => SplashScreenWidget(),
      MainTabScreen.routerName: (ctx) => MainTabScreen(),
      LoginScreenWidget.routerName: (ctx) => LoginScreenWidget(),
      ChatScreen.routerName: (ctx) => ChatScreen(ModalRoute.of(ctx).settings.arguments as User),
    };
