import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/core/constants/color_constants.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sizer/sizer.dart';

final loadingIndicator = LoadingIndicatorScreen(); // Global instance

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.2),
      child: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 16.0.h,
            child: LoadingIndicator(
              indicatorType: Indicator.ballScaleMultiple,
              colors: [TColors.btnRedColor, TColors.primaryYellow],
            ),
          ),
        ],
      )),
    );
  }
}

class LoadingIndicatorScreen {
  OverlayEntry? _overlayEntry;

  void show(BuildContext context) {
    if (_overlayEntry == null) {
      // Create and show the overlay only if it doesn't already exist
      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            ModalBarrier(dismissible: false, color: Colors.black.withOpacity(0.2)),
            Center(child: LoadingWidget()),
          ],
        ),
      );
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void hide() {
    // Remove the overlay only if it exists
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
