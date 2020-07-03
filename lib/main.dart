import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/onboarding/splash_screen.dart';
import 'package:samapp/utils/constant/app_router.dart';
import 'package:samapp/utils/constant/app_theme.dart';

import './generated/i18n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* Setup Firebase Database */
  await FirebaseApp.configure(
    name: 'TEST',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:323627227839:ios:98dd32d21a24f2cd3f440a',
            gcmSenderID: 'sam-dev-f9787',
            apiKey: 'AIzaSyDlyGjBFsnO87JSkSOcyWI9ljAavhf5x4Y',
            databaseURL: 'https://sam-dev-f9787.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:323627227839:android:eacc550a07680d923f440a',
            apiKey: 'AIzaSyDlyGjBFsnO87JSkSOcyWI9ljAavhf5x4Y',
            databaseURL: 'https://sam-dev-f9787.firebaseio.com',
          ),
  );

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
