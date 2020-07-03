import 'package:samapp/model/app_error.dart';

class FirebaseError extends AppError {
  FirebaseError({String code, String message}) : super(code: code, message: message);

  static const ERROR_NETWORK_CODE_UNKNOWN = '-10000';
  static const ERROR_NETWORK_CODE_PARSING = '-9999';
}
