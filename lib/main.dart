import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/main/main_tab_screen.dart';
import 'package:samapp/ui/onboarding/login_screen.dart';
import 'package:samapp/ui/onboarding/splash_screen.dart';
import 'package:samapp/utils/constant/dimen.dart';
import './generated/i18n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<RepositoryImp>(
      create: (context) => Repository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        /* Config locale */
        localizationsDelegates: [S.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        supportedLocales: S.delegate.supportedLocales,

        /* Config Theme */
        theme: ThemeData(
            fontFamily: 'Helveticaneue',
            primarySwatch: Colors.orange,
            accentColor: Colors.white,
            primaryColor: Color(0xFFF17423),
            secondaryHeaderColor: Color(0xFF2774BE),
            cursorColor: Color(0xFFF17423),
            focusColor: Color(0xFFF17423),
            backgroundColor: Color(0xFFe6eaf8),
            hoverColor: Color(0xFFEFEFEF),
            dividerColor: Color(0xFFdddddd),
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(color: Colors.white, fontSize: Dimen.fontHuge6),
                bodyText1: TextStyle(color: Colors.black, fontSize: Dimen.fontLarge),
                bodyText2: TextStyle(color: Colors.black, fontSize: Dimen.fontNormal),
                button: TextStyle(color: Colors.white, fontSize: Dimen.fontNormal),
                overline: TextStyle(
                  color: Colors.white,
                  fontSize: Dimen.fontTiny,
                ))),

        /* Config Router */
        initialRoute: SplashScreenWidget.routerName,
        routes: {
          SplashScreenWidget.routerName: (ctx) => SplashScreenWidget(),
          MainTabScreen.routerName: (ctx) => MainTabScreen(),
          LoginScreenWidget.routerName: (ctx) => LoginScreenWidget(),
        },
      ),
    );
  }
}
