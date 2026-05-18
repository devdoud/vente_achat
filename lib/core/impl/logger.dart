import 'package:logging/logging.dart';
import '../../export.dart';

@Singleton()
class AppLogger extends ILogger{
  final Logger logger;

  AppLogger({required this.logger});
  factory AppLogger.get() => getIt<AppLogger>();

  @override
  void logError(Object? message, [Object? error, StackTrace? stackTrace]) {
    logger.severe(message, error, stackTrace);
  }

  @override
  void logInfo(Object? message, [Object? error, StackTrace? stackTrace]) {
    logger.info(message, error, stackTrace);
  }

  @override
  void logWarning(Object? message, [Object? error, StackTrace? stackTrace]) {
    logger.warning(message, error, stackTrace);
  }
}