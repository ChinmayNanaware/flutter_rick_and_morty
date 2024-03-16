import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/core/constants/color_constants.dart';
import 'package:flutter_rick_and_morty/core/constants/common_constants.dart';

import 'package:sizer/sizer.dart';

class SecondaryButton extends StatefulWidget {
  final String buttonText;
  final bool isActive;
  final Function() onPressed;
  const SecondaryButton(
      {Key? key, required this.buttonText, required this.isActive, required this.onPressed})
      : super(key: key);

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.4.h),
            side: BorderSide(color: TColors.btnRedColor, width: 1.5))),
        backgroundColor: widget.isActive == false
            ? MaterialStateProperty.all(TColors.white)
            : MaterialStateProperty.all(TColors.white),
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
                  color: TColors.btnRedColor,
                  fontSize: 11.0.sp,
                )),
          ),
        ),
      ),
    );
  }
}
