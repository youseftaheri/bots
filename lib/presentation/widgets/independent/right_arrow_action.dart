import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/config/theme.dart';

class MyRightArrow extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const MyRightArrow(this.text, {Key key, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(text),
            Icon(
              Icons.trending_flat,
              color: AppColors.red,
            )
          ],
        ),
      ),
    );
  }
}
