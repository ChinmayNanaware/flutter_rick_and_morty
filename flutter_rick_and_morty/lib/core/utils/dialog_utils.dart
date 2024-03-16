import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/core/constants/color_constants.dart';
import 'package:flutter_rick_and_morty/core/constants/common_constants.dart';
import 'package:sizer/sizer.dart';

class DialogUtils {
  Future<bool> showAlertDialog({
    required BuildContext context,
    required String title,
    required String secondaryButtonText,
    required String primaryButtonText,
    required Function() onPrimaryTap,
    required Function() onSecondaryTap,
  }) async {
    final result = await showDialog<bool>(
      barrierDismissible: true,
      barrierColor: Colors.black26,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.2.h), // Increase corner radius for a larger feel
        ),
        contentPadding: EdgeInsets.all(2.0.h),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 12.0.sp,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actionsPadding: EdgeInsets.only(bottom: 2.0.h, left: 2.0.h, right: 2.0.h, top: 2.0.h),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.6.h),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(TColors.btnRedColor),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Container(
              width: screenWidth,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 1.4.h, 0.0, 1.4.h),
                  child: Text(primaryButtonText.toUpperCase(),
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0.sp,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.0.h,
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.6.h),
                  side: BorderSide(color: TColors.borderGrey, width: 1.5))),
              backgroundColor: MaterialStateProperty.all(TColors.borderGrey),
            ),
            onPressed: onSecondaryTap,
            child: Container(
              width: screenWidth,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 1.4.h, 0.0, 1.4.h),
                  child: Text(secondaryButtonText.toUpperCase(),
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                          color: TColors.black, fontSize: 10.0.sp, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // Ensure a non-nullable bool is returned
    return result ?? false;
  }

  Future<bool> showAlertDialogWithContent({
    required BuildContext context,
    required String title,
    String? content,
    required String secondaryButtonText,
    required String primaryButtonText,
    required Function() onPrimaryTap,
    required Function() onSecondaryTap,
  }) async {
    final result = await showDialog<bool>(
      barrierDismissible: true,
      barrierColor: Colors.black26,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.2.h), // Increase corner radius for a larger feel
        ),
        contentPadding: EdgeInsets.all(2.0.h),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 12.0.sp,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          content ?? '',
          style: TextStyle(
            fontSize: 10.0.sp,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actionsPadding: EdgeInsets.only(bottom: 2.0.h, left: 2.0.h, right: 2.0.h, top: 2.0.h),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.6.h),
                        side: BorderSide(color: TColors.btnRedColor, width: 1.5))),
                    backgroundColor: MaterialStateProperty.all(TColors.white),
                  ),
                  onPressed: onSecondaryTap,
                  child: Container(
                    width: screenWidth,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 1.4.h, 0.0, 1.4.h),
                        child: Text(secondaryButtonText.toUpperCase(),
                            textScaler: TextScaler.noScaling,
                            style: TextStyle(
                                color: TColors.btnRedColor,
                                fontSize: 10.0.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 2.0.h,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.6.h),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(TColors.btnRedColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    width: screenWidth,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 1.4.h, 0.0, 1.4.h),
                        child: Text(primaryButtonText.toUpperCase(),
                            textScaler: TextScaler.noScaling,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0.sp,
                            )),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );

    // Ensure a non-nullable bool is returned
    return result ?? false;
  }

  Future<bool> showUpdateDialog({
    required BuildContext context,
    required bool barrierDismissible,
    required String title,
    required String content,
    required String secondaryButtonText,
    required String primaryButtonText,
    required Function() onPrimaryTap,
    required Function() onSecondaryTap,
  }) async {
    final result = await showDialog<bool>(
      barrierDismissible: false,
      barrierColor: Colors.black26,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.2.h), // Increase corner radius for a larger feel
        ),
        contentPadding: EdgeInsets.all(2.0.h),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13.0.sp,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: TextStyle(
            fontSize: 11.0.sp,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actionsPadding: EdgeInsets.only(bottom: 2.0.h, left: 2.0.h, right: 2.0.h, top: 2.0.h),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.6.h),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(TColors.btnRedColor),
            ),
            onPressed: () {
              onPrimaryTap();
            },
            child: Container(
              width: screenWidth,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 1.4.h, 0.0, 1.4.h),
                  child: Text(primaryButtonText.toUpperCase(),
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0.sp,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.0.h,
          ),
          if (barrierDismissible)
            Center(
              child: TextButton(
                onPressed: onSecondaryTap,
                child: Text(secondaryButtonText.toUpperCase(),
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: TColors.errorRed, fontSize: 10.0.sp, fontWeight: FontWeight.w500)),
              ),
            ),
        ],
      ),
    );

    // Ensure a non-nullable bool is returned
    return result ?? false;
  }

  showSnackMessage(
    BuildContext context,
    String message,
    Color color,
  ) {
    // ignore: avoid_single_cascade_in_expression_statements
    Flushbar(
      isDismissible: true,
      boxShadows: [
        BoxShadow(
          blurRadius: 1.0.h,
          color: Colors.black26,
          spreadRadius: 0.3.h, //extend the shadow
        )
      ],
      messageSize: 8.0.sp,
      messageColor: TColors.white,
      borderRadius: BorderRadius.all(Radius.circular(0.5.h)),
      backgroundColor: color,
      margin: EdgeInsets.fromLTRB(2.0.h, 1.0.h, 2.0.h, 3.0.h),
      padding: EdgeInsets.fromLTRB(2.0.h, 1.0.h, 2.0.h, 1.0.h),
      flushbarPosition: FlushbarPosition.BOTTOM,
      messageText: Text(
        message,
        textScaler: TextScaler.noScaling,
        style: TextStyle(fontSize: 10.0.sp, color: TColors.white),
      ),
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
