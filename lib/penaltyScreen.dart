import 'package:blue_jeans/socketIoClnt.dart';
import 'package:flutter/material.dart';
import 'package:blue_jeans/waitingRoom.dart';
import 'package:blue_jeans/main.dart' as main;
import 'package:socket_io_client/socket_io_client.dart';

class DrawResult extends StatelessWidget {
  final ClientSocket socket;

  const DrawResult({super.key, required this.socket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: main.gray,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 750,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/drawResultScreen.png'),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 140, left: 110, right: 120),
                      child: Column(
                        children: [
                          Text(
                            socket.penalty, //여기에 벌칙 가지고 와야함
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Retro',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 354),
                            child: InkWell(
                              onTap: (() {
                                Navigator.pop(context);
                              }),
                              child: Image.asset(
                                'assets/confirmButton.png',
                                width: 150,
                                height: 46,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
