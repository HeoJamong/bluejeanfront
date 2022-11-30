import 'package:blue_jeans/main.dart';
import 'package:blue_jeans/balanceGame.dart';
import 'package:blue_jeans/socketIoClnt.dart';
import 'package:flutter/material.dart';

class BalanceGameLoading extends StatefulWidget {
  final ClientSocket socket;

  const BalanceGameLoading({super.key, required this.socket});

  @override
  State<BalanceGameLoading> createState() => _BalanceGameLoading();
}

class _BalanceGameLoading extends State<BalanceGameLoading> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BalanceGame(
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
                      image: AssetImage('assets/balanceGameLoding.png'),
                      fit: BoxFit.fill)),
            )
          ],
        ),
      ),
    );
  }
}
