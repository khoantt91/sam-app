import 'package:flutter/material.dart';
import 'package:samapp/utils/constant/app_color.dart';

import 'dimen.dart';

ThemeData get AppTheme => ThemeData(
    //TODO should refactor to AppColor
    fontFamily: 'Helveticaneue',
    primarySwatch: Colors.orange,
    accentColor: Colors.white,
    primaryColor: AppColor.primaryColor,
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
        )));
