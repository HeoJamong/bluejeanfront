import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:blue_jeans/loading.dart';
import 'package:blue_jeans/popup_screen.dart';

const background = Color.fromARGB(255, 1, 125, 125);
const gray = Color.fromRGBO(192, 192, 192, 1);
const blue = Color.fromARGB(255, 42, 47, 209);
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    ));

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bgm.loadAssets();
    // bgm.playBgm();
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.dispose();
    FlameAudio.bgm.play("bgm.mp3");
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
          child: Container(
        width: 400,
        height: 750,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/mainScreen.png"), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        optionDialog(context);
                      },
                      icon: Image.asset('assets/setting.png')),
                  IconButton(
                      onPressed: () {
                        showHelpDialog(context);
                      },
                      icon: Image.asset('assets/helpIcon.png'))
                  // showhelp
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Flexible(
                flex: 5,
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(minWidth: 200),
                    child: Image.asset(
                      'assets/main_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
            Spacer(flex: 2),
            Flexible(
              flex: 5,
              child: Container(
                constraints: BoxConstraints(minHeight: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Image.asset(
                        "assets/joinButton.png",
                        width: 250,
                        height: 50,
                      ),
                      onTap: () => joinRoomDialog(context),
                    ),
                    InkWell(
                      onTap: (() => createRoomDialog(context)),
                      child: Image.asset(
                        'assets/creatButton.png',
                        width: 250,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      )),
    );
  }
}
