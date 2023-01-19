//import 'package:chat_app/Authenticate/Methods.dart';
//import 'package:chat_app/Screens/ChatRoom.dart';
//import 'package:chat_app/group_chats/group_chat_screen.dart';

// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables, unused_field, library_private_types_in_public_api, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, curly_braces_in_flow_control_structures, must_be_immutable, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'fadeAnimation.dart';
import 'ChatRoom.dart';
import 'search.dart';

class Chat extends StatefulWidget {
  var name;
  Chat(this.name);
  @override
  _ChatState createState() => _ChatState(name);
}

class _ChatState extends State<Chat> {
  var name;
  _ChatState(this.name);
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //late List contacts;
  var selectedService;
  var email;
  List contactList = [];

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  Future<List> onshow() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var curent = FirebaseAuth.instance.currentUser?.email;
    await _firestore
        .collection('users')
        .where("email", isNotEqualTo: curent)
        .get()
        .then((value) {
      setState(() {
        contactList = [];
        for (int i = 0; i < value.docs.length; i++) {
          contactList.add(value.docs[i].data());
        }
      });
    });

    return contactList;
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Center(
              child: Text("chats",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
          actions: [
            Ink(
              decoration: const ShapeDecoration(
                //   color: Colors.lightBlue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.search_sharp),
                iconSize: 24,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
              ),
            ),
            // IconButton(
            //     icon: const Icon(Icons.logout),
            //     onPressed: () => logOut(context))
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1,
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
                  ),
                ))
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<List>(
                  future: onshow(),
                  builder: (context, snapshot) {
                    //  print(snapshot.data);
                    if (snapshot.hasData) {
                      //print(snapshot.data);
                      var d = snapshot.data?.length;

                      return GridView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount:
                              contactList.isEmpty ? 1 : contactList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 5.0,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (contactList.isEmpty) {
                              return Container();
                            }
                            return FadeAnimation(
                                (1.0 + index) / 4,
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        //print(snapshot.data![index]['name']);
                                        email = snapshot.data![index]
                                            ['email']; // email of other user
                                        //print("email :" + email);
                                        // print("name :" + name); // my name
                                        if (int.tryParse(name) == null) {
                                          String roomId = chatRoomId(
                                                  // _auth.currentUser!.displayName!,
                                                  name,
                                                  snapshot.data![index]
                                                      ['email'])
                                              .toString()
                                              .replaceAll("@gmail.com", "");
                                          // print(roomId);
                                          //snapshot.data![index]['email']);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => ChatScreen(
                                                _auth.currentUser!.email.toString(),
                                                  snapshot.data![index]
                                                      ['email']
                                                //chatRoomId: roomId,
                                                //userMap: snapshot.data![index],
                                              ),
                                            ),
                                          );
                                        } else {
                                          String roomId = chatRoomId(
                                              //   _auth.currentUser!.email!,

                                              snapshot.data![index]['email'],
                                              name
                                              //_auth.currentUser!.email!,
                                              );
                                          //name);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => ChatScreen(
                                                // chatRoomId: roomId,
                                                // userMap: snapshot.data![index],
                                                  _auth.currentUser!.email.toString(),
                                                  snapshot.data![index]
                                                      ['email']
                                              ),
                                            ),
                                          );
                                        }

                                        if (selectedService == index)
                                          selectedService = -1;
                                        else
                                          selectedService = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: selectedService == index
                                            ? Colors.blue.shade50
                                            : Colors.grey.shade100,
                                        border: Border.all(
                                          color: selectedService == index
                                              ? const Color.fromARGB(
                                                  255, 0, 0, 0)
                                              : const Color.fromARGB(
                                                      255, 0, 0, 0)
                                                  .withOpacity(0),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data![index]['email']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Icon(
                                                      Icons.chat,
                                                      size: 20,
                                                      color: Colors.black,
                                                    )),
                                              ]),
                                        ],
                                      ),
                                      // ignore: prefer_const_literals_to_create_immutables
                                    )));
                          });
                    } else {
                      return const Center(
                        child: Text(
                          'No Data',
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    }
                  }),
            )));
  }
}
