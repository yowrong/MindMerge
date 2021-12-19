import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late IO.Socket socket;
  late List<String> messages;
  late double height, width;
  late TextEditingController textController;
  late ScrollController scrollController;

  void transmitMessage(jsonData) {
    // Map<String, dynamic> data = json.decode(jsonData);
    print(jsonData);
    setState(() => messages.add(jsonData['message']));
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    messages = List<String>.empty(growable: true);
    textController = TextEditingController();
    scrollController = ScrollController();
    socket = IO.io('https://mindmerge-api.herokuapp.com', <String, dynamic>{
      'transports': ['websocket']
    });

    socket.onConnect((data) => print('Successfully connected to server.\n'));
    print(socket.connected);
    socket.on('welcome', transmitMessage);

    // socket.subscribe('receive_message', (jsonData) {
    //   Map<String, dynamic> data = json.decode(jsonData);
    //   this.setState(() => messages.add(data['message']));
    //   scrollController.animateTo(
    //     scrollController.position.maxScrollExtent,
    //     duration: Duration(milliseconds: 600),
    //     curve: Curves.ease,
    //   );
    // });
    // socketIO.connect();
    super.initState();
  }

  Widget buildSingleMessage(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          messages[index],
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return SizedBox(
      height: height * 0.8,
      width: width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (BuildContext contect, int index) {
          return buildSingleMessage(index);
        },
      ),
    );
  }

  Widget buildChatInput() {
    return Container(
      width: width * 0.7,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(left: 40.0),
      child: TextField(
        decoration: const InputDecoration.collapsed(
          hintText: 'Send a message...',
        ),
        controller: textController,
      ),
    );
  }

  Widget buildSendButton() {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () {
        if (textController.text.isNotEmpty) {
          socket.emit(
            'send_message',
            json.encode(
              {
                'message': textController.text,
              },
            ),
          );

          setState(() => messages.add(textController.text));
          textController.text = '';
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 600),
            curve: Curves.ease,
          );

          // socketIO.sendMessage(
          //   'send_message',
          //   json.encode(
          //     {
          //       'message': textController.text,
          //     },
          //   ),
          // );
          // this.setState(() => messages.add(textController.text));
          // textController.text = '';
          // scrollController.animateTo(
          //   scrollController.position.maxScrollExtent,
          //   duration: Duration(milliseconds: 600),
          //   curve: Curves.ease,
          // );
        }
      },
      child: const Icon(
        Icons.send,
        size: 30,
      ),
    );
  }

  Widget buildInputArea() {
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: height * 0.1),
            buildMessageList(),
            buildInputArea(),
          ],
        ),
      ),
    );
  }
}
