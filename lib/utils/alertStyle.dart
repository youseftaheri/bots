import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/config/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AlertStyle alertStyle() {
  return  AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
    descTextAlign: TextAlign.start,
    animationDuration: Duration(milliseconds: 500),
    backgroundColor: AppColors.black,
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(
        width: 0.5,
        color: AppColors.lightPrimary,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
    alertAlignment: Alignment.center,
  );
}