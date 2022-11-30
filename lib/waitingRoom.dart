import 'package:flutter/material.dart';
import 'package:blue_jeans/main.dart';
import 'package:blue_jeans/socketIoClnt.dart';
import 'package:provider/provider.dart';

const background = Color.fromARGB(255, 1, 125, 125);
const gray = Color.fromRGBO(192, 192, 192, 1);
const blue = Color.fromARGB(255, 42, 47, 209);

class WaitingRoom extends StatefulWidget {
  final String roomId;
  final List<String> gameList = ['터치 게임', '폭탄 돌리기', '밸런스 게임', '무작위 게임'];
  final ClientSocket websocket;
  final bool isCaptain;

  WaitingRoom(
      {Key? key,
      required this.roomId,
      required this.websocket,
      required this.isCaptain})
      : super(key: key);

  @override
  WaitingRoomState createState() => WaitingRoomState();
}

class WaitingRoomState extends State<WaitingRoom> {
  int _selectedGame = 1;
  var responsiveWidth;
  var responsiveHeight;

  @override
  void initState() {
    super.initState();
    print("in WaitingRoom");
    print("initstate");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    responsiveWidth = MediaQuery.of(context).size.width;
    responsiveHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Color.fromRGBO(0, 0, 0, 0),
          title: Text(widget.roomId,
              style: TextStyle(
                  fontSize: 35, fontFamily: 'Retro', color: Colors.black)),
          centerTitle: true,
          backgroundColor: gray,
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('?',
                  style: TextStyle(
                      fontSize: 40, fontFamily: 'Retro', color: Colors.black)),
            ),
            IconButton(
                onPressed: () {}, icon: Image.asset('assets/setting.png')),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    children: [
                      Container(
                          width: responsiveWidth * (8 / 10),
                          height: 30,
                          color: blue,
                          child: Text(
                            '참가자',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Retro',
                                color: Colors.white),
                          )),
                      Expanded(
                        child: Container(
                          width: responsiveWidth * (8 / 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          color: gray,
                          child: ChangeNotifierProvider.value(
                            value: widget.websocket,
                            child: Consumer<ClientSocket>(
                              builder: (context, value, child) {
                                var userList = value.getUserList();
                                int userCnt = userList.length;
                                return GridView.builder(
                                  itemCount: userCnt, //item 개수
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                                    childAspectRatio:
                                        2 / 1, //item 의 가로 1, 세로 2 의 비율
                                    mainAxisSpacing: 10, //수평 Padding
                                    crossAxisSpacing: 10, //수직 Padding
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    //item 의 반목문 항목 형성
                                    return Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(userList[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Retro')),
                                          Visibility(
                                            visible: widget.isCaptain,
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons
                                                    .disabled_by_default_outlined)),
                                          )
                                        ],
                                      ),
                                    );
                                    // );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Column(
                    children: [
                      Container(
                          width: responsiveWidth * (8 / 10),
                          height: 30,
                          color: blue,
                          child: Text(
                            '게임',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Retro',
                                color: Colors.white),
                          )),
                      Expanded(
                        child: Container(
                          width: responsiveWidth * (8 / 10),
                          padding: const EdgeInsets.all(10),
                          color: gray,
                          child: GridView.builder(
                            itemCount: widget.gameList.length, //item 개수
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                              childAspectRatio: 2 / 1, //item 의 가로 1, 세로 2 의 비율
                              mainAxisSpacing: 10, //수평 Padding
                              crossAxisSpacing: 10, //수직 Padding
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              //item 의 반목문 항목 형성
                              return Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(widget.gameList[index],
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: 'Retro')),
                                    Visibility(
                                      visible: widget.isCaptain,
                                      child: Radio<int>(
                                        value: index + 1,
                                        groupValue: _selectedGame,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _selectedGame = value!;
                                          });
                                          print('selected game : $value');
                                        },
                                        splashRadius: 0,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          //선택 시 파랑, 아니면 검정
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return blue;
                                          }
                                          return Colors.black;
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                                // ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: responsiveWidth * (8 / 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          visible: widget.isCaptain,
                          child: ElevatedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.yellow),
                            onPressed: () {
                              widget.websocket.startGameReq(_selectedGame);
                            },
                            child: Text(
                              "시작",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Retro',
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          child: Text(
                            "나가기",
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Retro',
                                color: Colors.black),
                          ),
                          onPressed: () {
                            widget.websocket.disconnect();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (__) => MainScreen()));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
