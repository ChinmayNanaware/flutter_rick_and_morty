import 'package:flutter_rick_and_morty/core/constants/color_constants.dart';
import 'package:flutter_rick_and_morty/core/utils/dialog_utils.dart';
import 'package:flutter_rick_and_morty/core/utils/navigator_utils.dart';

class NetworkError extends Error {
  final String message;

  NetworkError(this.message);

  @override
  String toString() {
    DialogUtils().showSnackMessage(NavigationService.mainNavigatorKey.currentContext!,
        "Network Error. Please check connection", TColors.errorRed);
    return 'NetworkError: $message';
  }
}

class ServerError extends Error {
  final int statusCode;
  final String message;

  ServerError(this.statusCode, this.message);

  @override
  String toString() {
    DialogUtils().showSnackMessage(
      NavigationService.mainNavigatorKey.currentContext!,
      "Message: $message, Status: $statusCode ",
      TColors.errorYellow,
    );
    return 'ServerError: statusCode: $statusCode, message: $message';
  }
}

class UnexpectedErrorException extends Error {
  final String message;
  UnexpectedErrorException(this.message);

  @override
  String toString() {
    DialogUtils().showSnackMessage(
      NavigationService.mainNavigatorKey.currentContext!,
      "Message: $message",
      TColors.errorRed,
    );
    return 'Unknown: $message';
  }
}
