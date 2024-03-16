import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var Log = Logger(
  printer: PrettyPrinter(
    printEmojis: true,
    colors: true,
    noBoxingByDefault: false,
    errorMethodCount: 0,
    methodCount: 0,
  ),
  filter: TFilter(),
);

var loggerNoStack = Logger(
    printer: PrettyPrinter(
        printEmojis: false,
        colors: false,
        noBoxingByDefault: true,
        excludeBox: {Level.debug: true},
        errorMethodCount: 0,
        methodCount: 0),
    filter: TFilter());

class TFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}
