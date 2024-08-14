import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:http/http.dart' as http;

import '../../app/api/planApi.dart';

class SocketTest extends StatefulWidget {
  const SocketTest({super.key});

  @override
  State<SocketTest> createState() => _SocketTestState();
}

class _SocketTestState extends State<SocketTest> {
  final apiPlanClient = ApiPlanClient();
  late StompClient stompClient;
  List<Message> list = [];
  final TextEditingController _textController = TextEditingController();
  int index =0;
  bool changed = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,()async{
      await getPlan();
      stompClient = StompClient(
        config: StompConfig.sockJS(
          url: 'https://trip-story.site/ws',
          onConnect: onConnect,
          beforeConnect: () async {
            print('waiting to connect...');
            await Future.delayed(const Duration(milliseconds: 200));
            print('connecting...');
          },
          onWebSocketError: (dynamic error) {
            print('WebSocket Error: $error');
            stompClient.deactivate();
          },
          onStompError: (dynamic error) {
            print('Stomp Error: $error');
            stompClient.deactivate();
          },
          onDisconnect: (frame) => print('Disconnected'),
        ),
      );
      stompClient.activate();
      setState(() {});
    });
  }

  void onConnect(StompFrame frame) {
    print('Connected to WebSocket');
    stompClient.subscribe(
      destination: '/topic/api/plan/1',
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);
        print('????? ${result}');
        if(result['command']=='swap'){
          if(changed){
            var element = list.removeAt(result['data'][0]);
            list.insert(result['data'][1],element);
          }
        }else{
          Map<String, dynamic> data = result['data'];
          list.add(Message.fromJson(data));
          index = data['idx'];
        }
        changed = true;
        setState(() {});
      },
    );
    // Timer.periodic(const Duration(seconds: 10), (_) {
    //   stompClient.send(
    //     destination: '/chat/write',
    //     body: '111',
    //   );
    // });
  }
  void sendMessage() async {
    print('Sending message');
    final messageContent = _textController.text;
    if (messageContent.isNotEmpty) {
      try {
        index++;
        final body = {
          "index": '${index}',
          'title': 'dasdasd',
          "content": '${_textController.text}',
        };
        stompClient.send(
          destination: '/api/plan/1/create',
          body: jsonEncode(body), // Use jsonEncode instead of jsonDecode
        );
      } catch (e) {
        print('Error sending message: $e');
      }
      _textController.text = '';
    }
  }
  void deleteMessage(int index)async {
    print('?? ${index}');
      try {
        final body = {
          'idx': '${index}',
        };
        stompClient.send(
          destination: '/api/plan/1/delete',
          body: jsonEncode(body),
        );
      } catch (e) {
        print('Error sending message: $e');
      }
  }
  void createPlan() async {
      try {
        final response = await http.post(
          Uri.parse('https://trip-story.site/plan/create/room'),
        );
        if (response.statusCode == 200) {
          print('Message sent: ${response.body}');
        } else {
          print('Failed to send message: ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  void changeIndex(int oldIndex, int newIndex) async{
      try {
        // print('old ${oldIndex}');
        // print('new ${newIndex}');
        // print('old ${list[oldIndex].index}');
        // print('new ${list[newIndex].index}');
        final body = [list[oldIndex].index,list[newIndex].index];
        stompClient.send(
          destination: '/api/plan/1/update/order',
          body: jsonEncode(body), // Use jsonEncode instead of jsonDecode
        );
      } catch (e) {
        print('Error sending message: $e');
      }

  }
  Future<void> getPlan() async {
    try {
      final response = await http.get(
        Uri.parse('https://trip-story.site/plan/1/history'),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        for (var item in jsonList) {
          list.add(Message.fromJson(item));
        }
        index = list.length;
      } else {
        print('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }
  Future<void> checkIndex()async{
    await apiPlanClient.checkPlanIndex('1');
  }
  Future<void> cancelIndex()async{
    await apiPlanClient.cancelPlanIndex('1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket Test'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: ()async{
                  await checkIndex();
                },
                  child: Text('등록')),
              // const SizedBox(height: 10,),
              // GestureDetector(
              //   onTap: ()async{
              //     await cancelIndex();
              //   },
              //     child: Text('취소')),
              GestureDetector(
                  onTap: ()async{
                    print('111');
                    deleteMessage(0);
                  },
                  child: Text('dasdasdasas')),
              const SizedBox(height: 100,),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ReorderableListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  buildDefaultDragHandles: false,
                  itemBuilder: (context,index) {
                    return ListTile(
                      key: Key('$index'),
                      title: Text(list[index].content),
                      trailing: ReorderableDragStartListener(
                          index: index,
                          child: Icon(Icons.drag_handle)),
                      tileColor: index.isOdd? Colors.blueAccent:Colors.lightBlueAccent,
                    );
                  },
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if(oldIndex<newIndex){
                        newIndex -= 1;
                      }
                      changed = false;
                      var element = list.removeAt(oldIndex);
                      list.insert(newIndex,element);
                      changeIndex(oldIndex, newIndex);
                    });
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          controller: _textController,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: "Send Message"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: ElevatedButton(
                          onPressed: sendMessage,
                          child: Icon(Icons.send),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Message {
  final String title;
  final String content;
  final int index;

  Message({required this.title, required this.content, required this.index});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      title: json['title'],
      content: json['content'],
      index: json['idx'],
    );
  }
}
