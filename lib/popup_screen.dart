import 'dart:convert';
import 'dart:math';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blue_jeans/main.dart';
import 'package:blue_jeans/socketIoClnt.dart';
import 'package:blue_jeans/userClass.dart';
import 'package:blue_jeans/waitingRoom.dart';
import 'package:blue_jeans/resultScreen.dart';
import 'package:blue_jeans/touchGame.dart';

//ClientSocket socket = ClientSocket();

String randomRoomId() {
  var random = Random();
  dynamic val = List<int>.generate(6, (i) => random.nextInt(247));
  return base64UrlEncode(val);
}

void fullRoomError(BuildContext context) {
  var dialog = Dialog(child: FullRoomErrorScreen());
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => dialog);
}

void roomIdError(BuildContext context) {
  var dialog = Dialog(child: roomIdErrorScreen());
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => dialog);
}

void nicknameError(BuildContext context) {
  var dialog = Dialog(child: nicknameErrorScreen());
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => dialog);
}

void optionDialog(BuildContext context) {
  var dialog = Dialog(child: OptionScreen());
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => dialog);
}

void createRoomDialog(BuildContext context) {
  var dialog = Dialog(child: CreateRoomScreen());
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => dialog);
}

void joinRoomDialog(BuildContext context) {
  var dialog = Dialog(child: JoinRoomScreen());
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => dialog);
}

void showHelpDialog(BuildContext context) {
  var dialog = Dialog(child: ShowHelpScreen());
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => dialog);
}

class ShowHelpScreen extends StatefulWidget {
  const ShowHelpScreen({super.key});

  @override
  State<ShowHelpScreen> createState() => _ShowHelpScreen();
}

class _ShowHelpScreen extends State<ShowHelpScreen> {
  int cnt = 0;
  List<String> helpTitle = ["진행방식", '터치게임', '밸런스게임', '폭탄 게임', '벌칙 뽑기'];
  List<String> helpContent = [
    "우측 상단 ? 버튼을 눌러 도움말을 확인할 수 있으며 톱니바퀴 버튼을 눌러 설졍 화면으로 이동할 수 있습니다. 방 참가하기 버튼을 누르고 닉네임과 방 코드를 입력하면 대기방에 참가할 수 있으며 방 생성하기 버튼을 누르고 닉네임을 입력하면 대기방을 생성할 수 있습니다.",
    "최상단에 방코드가 나타나 있으며 상단에 참가자 목록, 하단에 게임목록이 나타나 있습니다. 방장은 참가자 목록에 다른 색상으로 표시되며 방장은 하단 게임 목록에서 진행될 게임을 한 가지 선택하여 시작할 수 있습니다.",
    "터치 게임은 제한시간 내에 버튼을 가장 많이 터치한 사람이 승리하는 게입입니다. 제한 시간이 종료된 뒤 가장 적게 버튼을 터치한 사람은 벌칙을 받게 됩니다.",
    "밸런스 게임은 제한시간(5초)내에 두가지 선택지 중 하나를 선택해서 더 적은 인원들이 선택한 선택지를 고른 사람들이 탈락하는 게임입니다. 탈락자들은 다 같이 사이좋게 벌칙을 받습니다.",
    "폭탄 게임은 제한시간이 종료 되엇을 때 폭탄을 보유하고 있는 참가자가 패배하는 게임입니다. 폭탄을 가진 사람은 넘기기 버튼을 눌러 다른 사람에게 폭탄을 넘길 수 있고 폭탄이 터진 사람은 벌칙을 받게 됩니다.",
    "탈락한 사람들은 벌칙을 뽑아 나온 벌칙을 뽑아 나온 벌칙을 수행하게 됩니다. 행운을 빌어요"
  ];
  void nextHelp() {
    setState(() {
      cnt++;
    });
  }

  void beforeHelp() {
    setState(() {
      cnt--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 400,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/helpPage.png'), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 240),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset('assets/closeButton.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70, top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 90.0, right: 100, bottom: 30),
                    child: Text(
                      "${helpTitle[cnt]}",
                      style: TextStyle(fontSize: 28, fontFamily: "Retro"),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 80.0),
                      child: Text("${helpContent[cnt]}",
                          style:
                              TextStyle(fontSize: 16.5, fontFamily: "Retro")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 80.0,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: beforeHelp,
                          child: Image.asset(
                            'assets/beforeButton.png',
                            width: 75,
                            height: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: GestureDetector(
                            onTap: nextHelp,
                            child: Image.asset(
                              'assets/nextButton.png',
                              width: 75,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
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

class nicknameErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/error.png'), fit: BoxFit.fill)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 220.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset('assets/closeButton.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: Container(
              child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Text(
                    "별명이 중복 되었습니다.",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class roomIdErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/error.png'), fit: BoxFit.fill)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 220.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset('assets/closeButton.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: Container(
              child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Text(
                    "방코드가 틀립니다.",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionScreen extends StatelessWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FlameAudio.bgm.stop();
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/option.png'), fit: BoxFit.fill)),
      child: Column(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 200.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset('assets/closeButton.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400.0),
              child: SizedBox(
                height: 80,
                width: 150,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    'assets/confirmButton.png',
                  ),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  CreateRoomScreenState createState() => CreateRoomScreenState();
}

class CreateRoomScreenState extends State<CreateRoomScreen> {
  TextEditingController nicknameTEC = TextEditingController();
  String nickname = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: 400,
          height: 650,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/createRoom.png'), fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 250, top: 3.0, bottom: 220),
                child: Flexible(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset('assets/closeButton.png'),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                      style: TextStyle(fontFamily: 'Retro', fontSize: 20),
                      maxLength: 6,
                      controller: nicknameTEC,
                      decoration: InputDecoration(
                          counterText: '',
                          hintText: '닉네임을 입력하세요.',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colors.black45,
                                width: 3,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 3,
                              ))))),
              Spacer(
                flex: 2,
              ),
              Flexible(
                  flex: 2,
                  child: InkWell(
                      child: Image.asset(
                        'assets/confirmButton.png',
                        width: 150,
                        height: 80,
                      ),
                      onTap: () {
                        nickname = nicknameTEC.text;
                        String roomId = randomRoomId();

                        var data = User(name: nickname, roomId: roomId);
                        ClientSocket socket = ClientSocket(context);
                        socket.creatingRoomReq(data);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WaitingRoom(
                                      roomId: roomId,
                                      websocket: socket,
                                      isCaptain: true,
                                    )));
                      })),
              Spacer(
                flex: 2,
              ),
            ],
          )),
    );
  }
}

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  JoinRoomScreenState createState() => JoinRoomScreenState();
}

class JoinRoomScreenState extends State<JoinRoomScreen> {
  TextEditingController roomIdTEC = TextEditingController();
  TextEditingController nicknameTEC = TextEditingController();
  String roomId = "";
  String nickname = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: 650,
          width: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/joinRoom.png'), fit: BoxFit.fill),
          ),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 250, top: 3.0, bottom: 150),
              child: Flexible(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset('assets/closeButton.png'),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                constraints: BoxConstraints(minHeight: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                maxLength: 6,
                                style: TextStyle(
                                  fontFamily: 'Retro',
                                  fontSize: 20,
                                ),
                                controller: nicknameTEC,
                                decoration: InputDecoration(
                                    counterText: '',
                                    hintText: '닉네임을 입력하세요.',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(
                                          color: Colors.black45,
                                          width: 3,
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 3,
                                        ))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                maxLength: 8,
                                style: TextStyle(
                                  fontFamily: 'Retro',
                                  fontSize: 20,
                                ),
                                controller: roomIdTEC,
                                decoration: InputDecoration(
                                    counterText: '',
                                    hintText: '방 코드를 입력하세요.',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(
                                          color: Colors.black45,
                                          width: 3,
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 3,
                                        ))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30),
              child: Flexible(
                  child: InkWell(
                      child: Image.asset(
                        'assets/confirmButton.png',
                        width: 150,
                        height: 80,
                      ),
                      onTap: () {
                        nickname = nicknameTEC.text;
                        roomId = roomIdTEC.text;
                        var data = User(name: nickname, roomId: roomId);
                        ClientSocket socket = ClientSocket(context);
                        socket.joiningRoomReq(data);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WaitingRoom(
                                      roomId: roomId,
                                      websocket: socket,
                                      isCaptain: false,
                                    )));
                      })),
            )
          ])),
    );
  }
}

class FullRoomErrorScreen extends StatelessWidget {
  const FullRoomErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
