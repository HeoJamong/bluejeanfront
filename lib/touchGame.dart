import 'package:blue_jeans/main.dart' as main;
import 'package:blue_jeans/resultScreen.dart';
import 'package:blue_jeans/socketIoClnt.dart';
import 'package:flutter/material.dart';

class TouchGame extends StatefulWidget {
  final ClientSocket socket;

  const TouchGame({Key? key, required this.socket}) : super(key: key);

  @override
  State<TouchGame> createState() => _TouchCount();
}

class _TouchCount extends State<TouchGame> {
  int _counter = 0;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 10), () {
      widget.socket.touchGameResult(_counter);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(socket: widget.socket),
          ));
    });
    super.initState();
  }

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: main.gray,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: 390,
                height: 750,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/touchGameScreen.png'),
                        fit: BoxFit.fill)),
                child: Column(
                  children: <Widget>[
                    const SizedBox(width: 14),
                    Padding(
                        padding: const EdgeInsets.only(left: 20, top: 220),
                        child: Text(
                          '$_counter',
                          style: TextStyle(
                              fontSize: 65,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: GestureDetector(
                        onTap: _increment,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset(
                            'assets/touchButton.png',
                            width: 300,
                            height: 300,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
