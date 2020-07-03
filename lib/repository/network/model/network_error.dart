import 'package:samapp/model/app_error.dart';

class NetworkError extends AppError {
  NetworkError({String code, String message}) : super(code: code, message: message);

  static const ERROR_NETWORK_CODE_UNKNOWN = '-1000';
  static const ERROR_NETWORK_CODE_PARSING = '-999';
}
