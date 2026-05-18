abstract class ILogger{
  void logError(Object? message, [Object? error, StackTrace? stackTrace]);
  void logInfo(Object? message, [Object? error, StackTrace? stackTrace]);
  void logWarning(Object? message, [Object? error, StackTrace? stackTrace]);
}