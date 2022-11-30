import 'package:flutter/material.dart';
import 'package:blue_jeans/main.dart';
import 'package:lottie/lottie.dart';
import 'package:flame_audio/flame_audio.dart';

class LoadingScreen extends StatelessWidget {
  @override
  var Myimg = "assets/penalty.gif";
  Widget build(BuildContext context) {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.dispose();
    FlameAudio.bgm.play("bgm.mp3");
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
    });
    return SizedBox(child: Lottie.asset('assets/loading.json', repeat: false));
  }
}
