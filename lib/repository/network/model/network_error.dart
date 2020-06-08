class NetworkError {
  String code;
  String message;

  NetworkError({this.code, this.message});

  static const ERROR_CODE_UNKNOWN = '-1000';
  static const ERROR_CODE_PARSING = '-999';
}
