import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:blue_jeans/popup_screen.dart';
import 'package:blue_jeans/userClass.dart';
import 'package:blue_jeans/waitingRoom.dart';
import 'package:blue_jeans/touchGameLoading.dart';
import 'package:blue_jeans/circulatingBombGameLoading.dart';
import 'package:blue_jeans/balanceGameLoading.dart';
import 'package:blue_jeans/resultScreen.dart';

String JOIN_TITLE = 'join';
String CREATE_TITLE = 'create';
String DISCONNECT_TITLE = 'disconnect';
String START_TITLE = 'start';

typedef VoidCallback = void Function();

class ClientSocket with ChangeNotifier {
  ClientSocket(this.context) {
    connect();
  }

  //게임 방 생성 시 필요한 변수들
  BuildContext context;
  late Socket clntSocket;
  late List<dynamic> userList = [''];
  late String myName = '';
  late var game = 0;
  late bool isCaptain = false;

  //서버 에러 메세지 저장
  String errorMsg = 'Unknown Err :(';

  //밸런스게임 선택지 저장
  late List options = ['', ''];

  //폭탄게임 유저 순서와 폭탄 index
  late List bombUserList = [''];
  late int bombIndex = 0;
  late int myIndex = 0;

  //게임 결과 저장하는 변수들
  late List<dynamic> losers = [''];
  late String loserStr = '';
  late String penalty = '';
  late var score = {};

  List<dynamic> getUserList() {
    return userList;
  }

  //소켓 연결
  void connect() {
    print('ClientSocket created. Connect to server...');
    //연결
    clntSocket = io('ws://211.57.200.6:3000', <String, dynamic>{
      'transports': ['websocket'],
      'forceNew': 'false',
    });
  }

  //방 참가시 동작 - 방 접속 요청 전송, 방에 접속한 유저 리스트 갱신받음
  void joiningRoomReq(User json) {
    print('Join to the room');
    print('room ID : ${json.roomId}');
    myName = json.name;

    //emit에는 전송할 내용들 포함됨. 첫번째 param은 받는 타입(동작), 두번째 param은 데이터
    //방 참가 요청
    clntSocket.emit(JOIN_TITLE, json);

    //방 참가 응답 및 유저 리스트 갱신
    clntSocket.on(JOIN_TITLE, (response) {
      if (response['state'] == '200') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WaitingRoom(
                      roomId: json.roomId,
                      websocket: this,
                      isCaptain: false,
                    )));
        userList = response['users'];
        print('updated userList : $userList');
        notifyListeners();
      }
      //방 참가 에러
      else {
        errorMsg = response['msg'];
        errorScreen(context, errorMsg);
        clntSocket.off(JOIN_TITLE);
        errorMsg = 'Unknown Err :(';
      }
    });

    //게임 시작 응답
    clntSocket.on(START_TITLE, (response) {
      if (response['gameType'] == String) {
        game = int.parse(response['gameType']);
      } else {
        game = response['gameType'];
      }
      _gameResponseListener(response['gameType']);
      print('Game Started.');
    });
  }

  //방 생성 시 동작 - 방 생성 요청 전송, 방에 접속하는 유저 리스트 갱신받음
  void creatingRoomReq(User json) {
    print('create new the room');
    print('room ID : ${json.roomId}');
    myName = json.name;

    //방 생성 요청
    clntSocket.emit(CREATE_TITLE, json);

    //방 생성 응답
    clntSocket.on(CREATE_TITLE, (response) {
      if (response['state'] == '200') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WaitingRoom(
                      roomId: json.roomId,
                      websocket: this,
                      isCaptain: true,
                    )));
        print("Room Created Successfully!");
        userList[0] = json.name;
        isCaptain = true;
        notifyListeners();
      } else {
        errorMsg = response['msg'];
        errorScreen(context, errorMsg);
        clntSocket.off(CREATE_TITLE);
        errorMsg = 'Unknown Err :(';
      }
    });

    //방 참가 응답 및 유저 리스트 갱신
    clntSocket.on(JOIN_TITLE, (response) {
      if (response['state'] == '200') {
        userList = response['users'];
        print('updated userList : $userList');
        notifyListeners();
      }
    });

    //게임 시작 응답
    clntSocket.on(START_TITLE, (response) {
      if (response['gameType'] == String) {
        game = int.parse(response['gameType']);
      } else {
        game = response['gameType'];
      }
      _gameResponseListener(response['gameType']);
      print('Game Started.');
    });
  }

  //방 나가기 동작 - 서버에게 참가한 방을 나간다는 요청 전송
  void exitRoomReq() {
    isCaptain = false;
    clntSocket.emit('exit');
    clntSocket.off(JOIN_TITLE);
    clntSocket.off(CREATE_TITLE);
    clntSocket.off(START_TITLE);
  }

  //방장이 서버로 보내는 게임 시작 요청
  void startGameReq(int selectedGame) {
    clntSocket.emit(START_TITLE, {'gameType': selectedGame});
  }

  //클라이언트에서의 게임 시작
  void _gameResponseListener(int gameType) {
    //터치 게임 시작
    if (gameType == 1) {
      print('go to the TouchGame');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TouchGameLoading(socket: this)));
    }
    //폭탄 게임 시작
    else if (gameType == 2) {
      clntSocket.emit('bombGame');
      clntSocket.on('bombGame', (response) {
        bombUserList = response['users'];
        bombIndex = response['index'];
        myIndex = findMyIndex();
        notifyListeners();
      });
      print('go to the BombGame');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CirculatingBombGameLoading(socket: this)));
    }
    //밸런스 게임 시작
    else if (gameType == 3) {
      if (isCaptain) {
        clntSocket.emit('options');
      }
      clntSocket.on('options', (response) {
        //밸런스게임 선택지 받기
        options = response['option'];
        notifyListeners();
      });
      print('go to the BalanceGame');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BalanceGameLoading(socket: this)));
    }
  }

  //터치 게임 결과 전송 및 응답
  void touchGameResult(int myResult) {
    clntSocket.emit('touchGame', {'touchCount': myResult});
    print('Touch Game Ended');
    clntSocket.on('touchGameResult', (response) {
      if (response['losers'].runtimeType == String) {
        loserStr = response['losers'];
      } else {
        loserStr = '';
        losers = response['losers'];
        for (int i = 0; i < losers.length; i++) {
          loserStr += losers[i];
          if (i != losers.length - 1) {
            loserStr += ', ';
          }
        }
      }
      penalty = response['penalty'];
      score = response['score'];

      notifyListeners();
    });
  }

  int findMyIndex() {
    int myIdx = 0;
    for (int i = 0; i < bombUserList.length; i++) {
      if (bombUserList[i] == myName) {
        myIdx = i;
        break;
      }
    }
    return myIdx;
  }

  void throwBomb() {
    clntSocket.emit('bombGame');
    print('You Threw the bomb...');
  }

  void bombGameResult() {
    clntSocket.on('bombGameResult', (response) {
      print('Bomb Game Ended');
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(socket: this),
          ));
      if (response['losers'].runtimeType == String) {
        loserStr = response['losers'];
      } else {
        loserStr = '';
        losers = response['losers'];
        for (int i = 0; i < losers.length; i++) {
          loserStr += losers[i];
          if (i != losers.length - 1) {
            loserStr += ', ';
          }
        }
      }
      penalty = response['penalty'];

      notifyListeners();
    });
  }

  void balanceGameResult(String myOption) {
    clntSocket.emit('balanceGame', {'option': myOption});
    print('Balance Game Ended');
    clntSocket.on('balanceGameResult', (response) {
      if (response['losers'].runtimeType == String) {
        loserStr = response['losers'];
      } else {
        loserStr = '';
        losers = response['losers'];
        for (int i = 0; i < losers.length; i++) {
          loserStr += losers[i];
          if (i != losers.length - 1) {
            loserStr += ', ';
          }
        }
      }
      penalty = response['penalty'];
      score = response['score'];

      notifyListeners();
    });
  }

  void offTouchGameListener() {
    clntSocket.off('touchGameResult');
  }

  void offBombGameListener() {
    clntSocket.off('bombGame');
    clntSocket.off('bombGameResult');
  }

  void offBalanceGameListener() {
    clntSocket.off('options');
    clntSocket.off('balanceGameResult');
  }
}
