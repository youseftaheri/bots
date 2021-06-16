import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/config/theme.dart';

class MySummaryLine extends StatelessWidget {
  final String title;
  final String summary;

  const MySummaryLine({Key key, this.title, this.summary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - AppSizes.sidePadding * 2;
    var _theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.sidePadding, vertical: AppSizes.linePadding),
        child: Row(
          children: <Widget>[
            Container(
                width: width / 2,
                child: Text(title, style: _theme.textTheme.display3.copyWith(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: AppColors.colorPrimaryDark),)),
            Container(
                alignment: Alignment.centerRight,
                width: width / 2,
                child: Text(summary,
                    style: _theme.textTheme.display3.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _theme.primaryColor))),
          ],
        ));
  }
}
