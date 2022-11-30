import 'package:blue_jeans/socketIoClnt.dart';
import 'package:blue_jeans/waitingRoom.dart';
import 'package:flutter/material.dart';
import 'package:blue_jeans/main.dart' as main;
import 'package:blue_jeans/penaltyGatcha.dart';
import 'package:blue_jeans/resultScreen.dart';

class GatchaScreen extends StatelessWidget {
  final ClientSocket socket;

  const GatchaScreen({Key? key, required this.socket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: main.gray,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 751,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/gatchaScreen.png'),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.only(top: 500),
                child: InkWell(
                  child: Image.asset(
                    'assets/gatchaButton.png',
                    height: 250,
                    width: 150,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PenaltyGatcha(
                                  socket: socket,
                                )));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
