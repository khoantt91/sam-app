import 'package:logger/logger.dart';
import 'package:samapp/utils/constant/app_constant.dart';

/* Create global logger for log in debug mode */
class Log {
  static Logger _logger;
  static bool _isDebug = AppConstant.isDebug;

  static Logger get _loggerInstance {
    if (_logger == null) _initLogger();
    return _logger;
  }

  static void _initLogger() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: false,
      ),
    );
  }

  static void v(String message) => _isDebug ? _loggerInstance.v(message) : {};

  static void d(String message) => _isDebug ? _loggerInstance.d(message) : {};

  static void i(String message) => _isDebug ? _loggerInstance.i(message) : {};

  static void w(String message) => _isDebug ? _loggerInstance.w(message) : {};

  static void e(String message) => _isDebug ? _loggerInstance.e(message) : {};
}
