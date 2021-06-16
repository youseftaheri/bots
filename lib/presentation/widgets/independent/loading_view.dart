import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_flutter_test_app1/utils/animations/AnimatedBackground.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedBackground(),
        Center(
          child: Lottie.asset('assets/lottieFiles/loading_1.json',
              width: 230,
              height: 230,
              fit: BoxFit.fill
          ),
        )
      ],
    );


    //   Center(
    //   child: CircularProgressIndicator(),
    // );
  }
}
