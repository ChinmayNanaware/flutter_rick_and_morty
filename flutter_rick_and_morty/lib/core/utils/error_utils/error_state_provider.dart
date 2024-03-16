import 'package:flutter/material.dart';

class ErrorStateProvider with ChangeNotifier {
  bool showErrorPage = false;

  void navigateToErrorPage() {
    showErrorPage = true;
    notifyListeners();
  }
}
