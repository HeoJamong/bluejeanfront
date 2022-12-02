import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blue_jeans/main.dart' as main;
import 'package:blue_jeans/socketIoClnt.dart';
import 'package:blue_jeans/penaltyGatcha.dart';

class GatchaScreen extends StatefulWidget {
  final ClientSocket socket;

  const GatchaScreen({Key? key, required this.socket}) : super(key: key);

  @override
  State<GatchaScreen> createState() => _GatchaScreenState();
}

class _GatchaScreenState extends State<GatchaScreen> {
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: ChangeNotifierProvider.value(
                      value: widget.socket,
                      child: Consumer<ClientSocket>(
                          builder: ((context, value, child) {
                        return Text(
                          value.loserStr,
                          style: TextStyle(fontSize: 28, fontFamily: "Retro"),
                        );
                      })),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 260),
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
                                      socket: widget.socket,
                                    )));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
