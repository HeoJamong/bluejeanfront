import 'package:blue_jeans/main.dart';
import 'package:blue_jeans/socketIoClnt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CirculatingBombGame extends StatefulWidget {
  final ClientSocket socket;

  const CirculatingBombGame({super.key, required this.socket});

  @override
  State<CirculatingBombGame> createState() => _CirculatingBombGame();
}

class _CirculatingBombGame extends State<CirculatingBombGame> {
  List<String> description = ["다음 사람에게 폭탄을 넘기세요!", "폭탄이 날아올 수 있습니다..."];

  @override
  void initState() {
    widget.socket.bombGameResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 390,
              height: 750,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/circulatingBombGameScreen.png'),
                      fit: BoxFit.fill)),
              child: ChangeNotifierProvider.value(
                value: widget.socket,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 440.0),
                      child: SizedBox(
                        height: 100,
                        width: 150,
                        child: Consumer<ClientSocket>(
                            builder: (context, value, child) {
                          if (value.myIndex == value.bombIndex) {
                            print('You Got the Bomb!');
                            return Text(description[0],
                                style: TextStyle(
                                    fontSize: 16.5,
                                    fontFamily: "Retro",
                                    color: Colors.red));
                          }
                          return Text(description[1],
                              style: TextStyle(
                                  fontSize: 16.5, fontFamily: "Retro"));
                        }),
                      ),
                    ),
                    Consumer<ClientSocket>(builder: (context, value, child) {
                      return Visibility(
                        visible: (value.bombIndex == value.myIndex),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: IconButton(
                              onPressed: () {
                                widget.socket.throwBomb();
                              },
                              icon: Image.asset(
                                'assets/throwBombButton.png',
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
