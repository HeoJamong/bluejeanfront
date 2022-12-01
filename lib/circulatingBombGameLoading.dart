import 'package:blue_jeans/circulatingBombGame.dart';
import 'package:blue_jeans/main.dart';
import 'package:blue_jeans/socketIoClnt.dart';

import 'package:flutter/material.dart';

class CirculatingBombGameLoading extends StatefulWidget {
  final ClientSocket socket;

  const CirculatingBombGameLoading({super.key, required this.socket});

  @override
  State<CirculatingBombGameLoading> createState() =>
      _CirculatingBombGameLoading();
}

class _CirculatingBombGameLoading extends State<CirculatingBombGameLoading> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CirculatingBombGame(
              socket: widget.socket,
            ),
          ));
    });
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
              width: 400,
              height: 750,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/circulatingBombGameLoding.png'),
                      fit: BoxFit.fill)),
            )
          ],
        ),
      ),
    );
  }
}
