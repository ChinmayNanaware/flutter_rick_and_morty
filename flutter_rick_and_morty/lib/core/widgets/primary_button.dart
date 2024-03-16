import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/core/constants/color_constants.dart';
import 'package:flutter_rick_and_morty/core/constants/common_constants.dart';

import 'package:sizer/sizer.dart';

class PrimaryButton extends StatefulWidget {
  final String buttonText;
  final bool isActive;
  final Function() onPressed;
  const PrimaryButton(
      {Key? key, required this.buttonText, required this.isActive, required this.onPressed})
      : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.4.h),
          ),
        ),
        backgroundColor: widget.isActive == false
            ? MaterialStateProperty.all(TColors.btnRedColor.withOpacity(0.5))
            : MaterialStateProperty.all(TColors.btnRedColor),
      ),
      onPressed: widget.isActive == false ? null : widget.onPressed,
      child: Container(
        width: screenWidth,
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 1.8.h, 0.0, 1.8.h),
            child: Text(widget.buttonText.toUpperCase(),
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0.sp,
                )),
          ),
        ),
      ),
    );
  }
}
