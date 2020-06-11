// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class S {
 
  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }
  
  static Future<S> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new S();
    });
  }
  
  String common_app_version(version) {
    return Intl.message("Phiên bản ${version}", name: 'common_app_version', args: [version]);
  }

  String get common_three_dot {
    return Intl.message("...", name: 'common_three_dot');
  }

  String get common_welcome_to {
    return Intl.message("Chào mừng đến với", name: 'common_welcome_to');
  }

  String get common_full_app_name {
    return Intl.message("Ứng Dụng Thống Kê & Quản Lý", name: 'common_full_app_name');
  }

  String get common_username {
    return Intl.message("Tên đăng nhập", name: 'common_username');
  }

  String get common_password {
    return Intl.message("Mật khẩu", name: 'common_password');
  }

  String get common_sign_in {
    return Intl.message("Đăng nhập", name: 'common_sign_in');
  }

  String common_count_deal(number) {
    return Intl.message("${number} deals", name: 'common_count_deal', args: [number]);
  }

  String get common_filter_data {
    return Intl.message("Lọc dữ liệu", name: 'common_filter_data');
  }

  String get common_sign_in_success {
    return Intl.message("Đăng nhập thành công", name: 'common_sign_in_success');
  }

  String get bottom_main_menu_home {
    return Intl.message("Trang Chủ", name: 'bottom_main_menu_home');
  }

  String get bottom_main_menu_listing {
    return Intl.message("Listing", name: 'bottom_main_menu_listing');
  }

  String get bottom_main_menu_deal {
    return Intl.message("Deal", name: 'bottom_main_menu_deal');
  }

  String get bottom_main_menu_chat {
    return Intl.message("Chat", name: 'bottom_main_menu_chat');
  }

  String get bottom_main_menu_notification {
    return Intl.message("Thông Báo", name: 'bottom_main_menu_notification');
  }

  String get listing_screen_title {
    return Intl.message("Danh Sách Listing", name: 'listing_screen_title');
  }

  String get deal_screen_title {
    return Intl.message("Danh Sách Deal", name: 'deal_screen_title');
  }


}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("vi", ""),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return S.load(locale);
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

// ignore_for_file: unnecessary_brace_in_string_interps
