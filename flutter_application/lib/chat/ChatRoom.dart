// ignore_for_file: no_logic_in_create_state, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/constants.dart';

final _firestore = FirebaseFirestore.instance;
//late User sighnedInUser;
late String senderUser;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat';
  String sendeUser;
  String receiverUser;

  ChatScreen(this.sendeUser, this.receiverUser, {super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState(sendeUser, receiverUser);
}

class _ChatScreenState extends State<ChatScreen> {
  String sendeUser, receiverUser;
  _ChatScreenState(this.sendeUser, this.receiverUser);
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? MessageText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentUser();
    print("sender: " + sendeUser);
    print("receiver: " + receiverUser);
    senderUser = sendeUser;
  }

  // void getCurrentUser() {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       sighnedInUser = user;
  //       print(sighnedInUser.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: const [
            // Image.asset(
            //   "assets/img/user.png",
            //   height: 40,
            // ),
            SizedBox(width: 10),
            // Text(receiverUser.name!)
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessagesStreamBuilder(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0Xff9fc9f3),
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        MessageText = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': MessageText,
                        'sender': sendeUser,
                        'receiver': receiverUser,
                        'time': FieldValue.serverTimestamp()
                      });
                    },
                    child: const Icon(
                      Icons.send,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStreamBuilder extends StatelessWidget {
  const MessagesStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messageWidgets = [];
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: kPrimaryLightColor,
              ),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final messageReceiver = message.get('receiver');
            final currentUser = senderUser;

            if (currentUser == messageSender) {
              //the code from singed in user
            }
            final messageWidget = MessageLine(
              sender: messageSender,
              receiver: messageReceiver,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageWidgets.add(messageWidget);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidgets,
            ),
          );
        });
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine(
      {this.text, this.sender, required this.isMe, Key? key, this.receiver})
      : super(key: key);
  final String? sender;
  final String? receiver;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Text(
          //   '$sender',
          //   style: TextStyle(
          //     fontSize: 12,
          //     color: Colors.yellow[900],
          //   ),
          // ),
          Material(
            elevation: 7,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? kSecondColor : kPrimaryLightColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$text ',
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
