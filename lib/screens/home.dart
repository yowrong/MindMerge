import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindmerge/constants/colours.dart';
import 'package:mindmerge/constants/screen_args.dart';
import 'package:mindmerge/models/player.dart';
import 'package:mindmerge/screens/lobby.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'lobby.dart';

class Home extends StatefulWidget {
  static const String route = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _playerNameController = TextEditingController();
  String? _playerName;

  final TextEditingController _roomCodeController = TextEditingController();
  String? _roomCode;

  late IO.Socket socket;

  @override
  void initState() {
    socket = IO.io('https://mindmerge-api.herokuapp.com', <String, dynamic>{
      'transports': ['websocket']
    });
    socket.on("createRoom", (data) {
      print(data);

      // var array = data['players'];
      // List<Player> players = List<Player>.from(array);

      List<Player> players = data['players'].map<Player>((player) {
        // print('\n\n$player');
        return Player(
          id: player['id'],
          name: player['username'],
          cardsLeft: 0,
        );
      }).toList() as List<Player>;

      Navigator.pushNamed(
        context,
        Lobby.route,
        arguments: LobbyArguments(roomCode: _roomCode, players: players),
      );
    });
    socket.on("initRoom", initRoom);
    socket.on("confirmRoom", confirmRoom);
    super.initState();
  }

  @override
  void dispose() {
    _playerNameController.dispose();
    _roomCodeController.dispose();
    super.dispose();
  }

  void createRoom() {
    socket.emit(
      "createRoom",
      _playerName,
    );
  }

  void initRoom(jsonData) async {
    print(jsonData);
    setState(() => _roomCode = jsonData['roomCode'] as String);
    List<Player> players = jsonData['players'].map<Player>((player) {
      // print('\n\n$player');
      return Player(
        id: player['id'],
        name: player['username'],
        cardsLeft: 0,
      );
    }).toList() as List<Player>;
    Navigator.pushNamed(
      context,
      Lobby.route,
      arguments: LobbyArguments(
        roomCode: _roomCode,
        players: players,
      ),
    );
  }

  void joinRoom(String roomCode) {
    socket.emit(
      "roomCode",
      {"roomCode": roomCode},
    );
  }

  void confirmRoom(jsonData) async {
    print(jsonData);
    Navigator.pushNamed(
      context,
      Lobby.route,
      arguments: LobbyArguments(
        roomCode: jsonData['roomCode'],
        players: jsonData['players'],
      ),
    );
  }

  void createUser(String userName) {
    socket.emit(
      "userName",
      {"userName": userName},
    );
  }

  Widget _buildEnterName(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: width,
          child: TextField(
            controller: _playerNameController,
            decoration: InputDecoration(
              labelText: 'Enter Your Name'.toUpperCase(),
              labelStyle: const TextStyle(
                fontFamily: 'BalooBhai',
                fontSize: 24,
              ),
            ),
          ),
        ),
        const SizedBox(height: 45),
        SizedBox(
          width: width,
          child: InkWell(
            child: ElevatedButton(
              onPressed: () {
                String enteredName = _playerNameController.text.trim();
                if (enteredName != '') {
                  setState(() => _playerName = enteredName);
                }
              },
              child: Text(
                'Start'.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'BalooBhai',
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomButtons(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: width,
          child: InkWell(
            child: ElevatedButton(
              onPressed: () {
                createRoom();
              },
              child: Text(
                'Create a Room'.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'BalooBhai',
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 75,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: primaryColor,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('or'),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 150,
              child: TextField(
                controller: _roomCodeController,
                decoration: InputDecoration(
                  labelText: 'Enter Code'.toUpperCase(),
                  labelStyle: const TextStyle(
                    fontFamily: 'BalooBhai',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: InkWell(
                child: ElevatedButton(
                  onPressed: () {
                    String enteredRoomCode = _roomCodeController.text.trim();
                    if (enteredRoomCode != '') {
                      joinRoom(enteredRoomCode);
                    }
                    // TODO: Make call to server using room code
                  },
                  child: Text(
                    'Join one'.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'BalooBhai',
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 90,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/icons/logo.svg',
                  height: screenHeight * 0.2,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'FuzzyBubbles',
                    fontSize: 48,
                    color: darkColor,
                  ),
                  children: [
                    TextSpan(
                      text: _playerName != null ? 'Hello ' : 'Mind',
                    ),
                    TextSpan(
                      text: _playerName ?? 'Merge',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: primaryColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              if (_playerName == null)
                Text(
                  'Team 37 + Kevin'.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'BalooBhai',
                  ),
                ),
              const Spacer(),
              _playerName == null
                  ? _buildEnterName(screenWidth * 0.3)
                  : _buildRoomButtons(screenWidth * 0.3),
            ],
          ),
        ),
      ),
    );
  }
}
