import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/onboarding/splash_screen.dart';
import 'package:samapp/utils/constant/app_router.dart';
import 'package:samapp/utils/constant/app_theme.dart';

import './generated/i18n.dart';

void main() {
  runApp(SamApp());
}

class SamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* Config Provider */
    return RepositoryProvider<RepositoryImp>(
      create: (context) => Repository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        /* Config locale */
        localizationsDelegates: [S.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        supportedLocales: S.delegate.supportedLocales,

        /* Config theme */
        theme: AppTheme,

        /* Config router */
        initialRoute: SplashScreenWidget.routerName,
        routes: AppRouter,
      ),
    );
  }
}
