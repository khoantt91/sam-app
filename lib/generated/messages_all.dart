// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

final _$vi = $vi();

class $vi extends MessageLookupByLibrary {
  get localeName => 'vi';
  
  final messages = {
		"common_app_version" : (version) => "Phiên bản ${version}",
		"common_welcome_to" : MessageLookupByLibrary.simpleMessage("Chào mừng đến với"),
		"common_full_app_name" : MessageLookupByLibrary.simpleMessage("Ứng Dụng Thống Kê & Quản Lý"),
		"common_username" : MessageLookupByLibrary.simpleMessage("Tên đăng nhập"),
		"common_password" : MessageLookupByLibrary.simpleMessage("Mật khẩu"),
		"common_sign_in" : MessageLookupByLibrary.simpleMessage("Đăng nhập"),
		"common_count_deal" : (number) => "${number} deals",
		"common_filter_data" : MessageLookupByLibrary.simpleMessage("Lọc dữ liệu"),
		"common_sign_in_success" : MessageLookupByLibrary.simpleMessage("Đăng nhập thành công"),
		"bottom_main_menu_home" : MessageLookupByLibrary.simpleMessage("Trang Chủ"),
		"bottom_main_menu_listing" : MessageLookupByLibrary.simpleMessage("Listing"),
		"bottom_main_menu_deal" : MessageLookupByLibrary.simpleMessage("Deal"),
		"bottom_main_menu_chat" : MessageLookupByLibrary.simpleMessage("Chat"),
		"bottom_main_menu_notification" : MessageLookupByLibrary.simpleMessage("Thông Báo"),
		"listing_screen_title" : MessageLookupByLibrary.simpleMessage("Danh Sách Listing"),
		"deal_screen_title" : MessageLookupByLibrary.simpleMessage("Danh Sách Deal"),

  };
}



typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
	"vi": () => Future.value(null),

};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case "vi":
        return _$vi;

    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName,
          (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());

  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);

  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}

// ignore_for_file: unnecessary_brace_in_string_interps
