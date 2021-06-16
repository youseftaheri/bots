import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: always_declare_return_types
showCustomAlertPopup({BuildContext context,
    String type, AlertStyle style,
    String title, String message,
    String button1, VoidCallback onTap1,
    String button2, VoidCallback onTap2}) async {
  await Alert(
    context: context,
    style: style,
    title: title,
    desc: message,
    image: Image.asset('assets/images/logo/logo02.webp'),
    buttons:
    button1.isEmpty ? [] :
      (button2.isEmpty ? [
        DialogButton(
      onPressed: onTap1,
    child: Text(button1, style: TextStyle(fontFamily: 'Iransans', color: AppColors.white,fontSize: 15),
    ),
  )] : [DialogButton(
               onPressed: onTap1,
               child: Text(button1, style: TextStyle(fontFamily: 'Iransans', color: Colors.white, fontSize: 15),),
        ),
        DialogButton(
               onPressed: onTap2,
               child: Text(button2, style: TextStyle(fontFamily: 'Iransans', color: Colors.white, fontSize: 15),),
        )]
  )).show();
}