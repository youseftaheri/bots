import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/config/theme.dart';
import 'package:my_flutter_test_app1/utils/animations/simple_animations_package.dart';

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: AppColors.white, end: AppColors.colorPrimary)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: AppColors.colorPrimaryDark, end: AppColors.white))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}