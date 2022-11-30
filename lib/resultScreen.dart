import 'package:blue_jeans/socketIoClnt.dart';
import 'package:flutter/material.dart';
import 'package:blue_jeans/main.dart';
import 'package:blue_jeans/gatchaScreen.dart';
import 'package:blue_jeans/penaltyGatcha.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  final ClientSocket socket;

  ResultScreen({Key? key, required this.socket}) : super(key: key);

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      //터치게임 소켓 listen 해제
      widget.socket.offTouchGameListener();

      //밸런스게임 소켓 listen 해제
      widget.socket.offBalanceGameListener();

      //폭탄게임 소켓 listen 해제
      widget.socket.offBombGameListener();

      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GatchaScreen(socket: widget.socket),
          ));
    });
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
                      image: AssetImage('assets/resultScreen.png'),
                      fit: BoxFit.fill)),
              child: ChangeNotifierProvider.value(
                value: widget.socket,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 260, left: 100, right: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "탈  락",
                            style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'Retro',
                                color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Consumer<ClientSocket>(
                              builder: ((context, value, child) {
                                //탈락자들을 출력하는 텍스트
                                return Text(
                                  value.loserStr,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Retro',
                                      color: blue),
                                  textAlign: TextAlign.center,
                                );
                              }),
                            ),
                          ),
                          Text(
                            "님이 탈락하셨습니다!",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Retro',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Consumer<ClientSocket>(
                              builder: (context, value, child) {
                                //폭탄게임일 경우, 폭발 이미지 출력
                                if (value.game == 2) {
                                  return SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: Image.asset(
                                        'assets/bombEffect.png',
                                      ));
                                }
                                //터치게임, 밸런스게임 결과를 출력
                                else {
                                  return SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: ListView.builder(
                                          itemCount: value.score.length,
                                          itemBuilder: (context, index) {
                                            return Text(
                                              '${value.userList[index]} : ${value.score[value.userList[index]]}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Retro',
                                              ),
                                            );
                                          }));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
