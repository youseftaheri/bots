import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_test_app1/utils/alertStyle.dart';
import 'package:my_flutter_test_app1/utils/show_custom_alert_popup.dart';
import '../../config/theme.dart';
import '../../utils/animations/simple_animations_package.dart';
import 'package:page_transition/page_transition.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool showUpdatePopup = false;

  Future<Null> startTime() async {
    var _duration = Duration(seconds: 3);
    Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    _navigateToLoginRegister(context);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }
  Future<bool> _onWillPop() async {
    return (
        showCustomAlertPopup(context: context,
          type: 'fail',
          style: alertStyle(),
          title: '',
          message: 'Are you sure you want to EXIT?',
          button1: 'Yes',
          onTap1:() {
            SystemNavigator.pop();
          },
          button2: 'No',
          onTap2: () {
            Navigator.of(context).pop(false);
          },)
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
          onWillPop: _onWillPop,
          child:
        Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned.fill(child: AnimatedBackground()),
                Align(
                    alignment: Alignment.center,
                    child:
                    Image.asset('assets/img/star.png',
                      fit: BoxFit.cover,
                      width: 200,)
                ),
              ],
            )
        )
      );

  }

  void _navigateToLoginRegister(BuildContext context) =>
      Navigator.pushReplacement(context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 1500),
              child: MainScreen() // LoginRegisterScreen()
          )
      );
}

class Particles extends StatefulWidget {
  final int numberOfParticles;

  Particles(this.numberOfParticles);

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles.add(ParticleModel(random));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateParticles,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}

class ParticleModel {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random;

  ParticleModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final duration = Duration(milliseconds: 3000 + random.nextInt(6000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.2 + random.nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;

  ParticlePainter(this.particles, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(200);

    particles.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
      Offset(animation["x"] * size.width, animation["y"] * size.height);
      final position2 =
      Offset(animation["x"] * size.width, animation["y"] * size.height+50);
      canvas.drawLine(position2, position, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: AppColors.colorPrimaryDark, end: AppColors.white)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: AppColors.colorPrimaryDark, end: AppColors.colorPrimaryDark))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}


class CenteredText extends StatelessWidget {
  const CenteredText({
    Key key,
    this.img,
    this.title,
  }) : super(key: key);

  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child:
      Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(img, width: 200,
              height: 200),
        ],
      ),
    );
  }
}