import 'package:blue_jeans/main.dart';
import 'package:blue_jeans/socketIoClnt.dart';
import 'package:blue_jeans/touchGame.dart';
import 'package:flutter/material.dart';

class TouchGameLoading extends StatefulWidget {
  final ClientSocket socket;

  const TouchGameLoading({super.key, required this.socket});

  @override
  State<TouchGameLoading> createState() => _TouchGameLoading();
}

class _TouchGameLoading extends State<TouchGameLoading> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TouchGame(
              socket: widget.socket,
            ),
          ));
    });
    super.initState();
  }

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
                      image: AssetImage('assets/touchGameLoding.png'),
                      fit: BoxFit.fill)),
            )
          ],
        ),
      ),
    );
  }
}
