import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/config/theme.dart';
import 'package:my_flutter_test_app1/utils/constants/strings.dart';
import '../splash_screen.dart';
import 'realtime_chart.dart';
import 'dart:math';

class StreamScreen extends StatefulWidget {

  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  double _y0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _y0 = Random().nextDouble();
    });
    return  Scaffold(
      body: Stack(children: <Widget>[
        AnimatedBackground(),
        Center(
          child: Container(height: MediaQuery.of(context).size.height - 100, child: RealtimeChart(y0: _y0,)),
        ),
        Stack(children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text(
                  Strings.stream
                  , textAlign: TextAlign.center, style: TextStyle(fontSize: 19,
                    fontFamily: 'Iransans', fontWeight: FontWeight.bold,
                    color: AppColors.black),
                ),
              ],
            ),
          ),
        ],
        ),
      ]
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}