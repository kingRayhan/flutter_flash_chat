import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/common/firebase_repository.dart';
import 'package:flash_chat/common/toast.dart';
import 'package:flash_chat/models/chat_msg.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('createAt', descending: false)
      .snapshots();

  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  // List<ChatMessageModel> messages = [
  //   ChatMessageModel(userId: "", text: "Hi Threre"),
  //   ChatMessageModel(userId: "", text: "hello"),
  //   ChatMessageModel(userId: "", text: "Ki koro?"),
  //   ChatMessageModel(userId: "", text: "Bal falai, tumi?"),
  // ];

  @override
  void initState() {
    initFirebaseState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                await _firebaseAuth.signOut();
              }),
        ],
        title: const Text('⚡️Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff075e54),
        elevation: 0,
      ),
      bottomSheet: _chatSender(),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _messagesStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            List<ChatMessageModel> messages = snapshot.data!.docs.map((doc) {
              var msgJson = doc.data()! as Map<String, dynamic>;
              return ChatMessageModel.fromJson(msgJson);
            }).toList();

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                bool isMe =
                    messages[index].userId == _firebaseAuth.currentUser!.uid;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 1.0),
                  child: BubbleSpecialTwo(
                    text: messages[index].text!,
                    color: isMe ? Color(0xff075e54) : Colors.black12,
                    tail: false,
                    textStyle: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 18),
                    isSender: isMe,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Container _chatSender() {
    TextEditingController textController = TextEditingController();
    return Container(
      decoration: kMessageContainerDecoration,
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: kMessageTextFieldDecoration,
            ),
          ),
          MaterialButton(
            onPressed: () async {
              if (textController.text == '') return;
              var msg = ChatMessageModel(
                userId: _firebaseAuth.currentUser!.uid,
                text: textController.text,
                createAt: Timestamp.now(),
              );
              await _firestoreRepository.createOne(
                data: msg.toJson(),
                collection: 'messages',
              );
              textController.clear();
            },
            child: const Text(
              'Send',
              style: kSendButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  void initFirebaseState() {
    _firebaseAuth.authStateChanges().listen((User? user) async {
      if (user == null) {
        showToast(
            message: "You are not logged in",
            context: context,
            type: ToastType.error);
        Navigator.pushNamed(context, WelcomeScreen.id);
      }

      // if (user != null && !user.emailVerified) {
      //   showToast(
      //       message: "A verification mail send to your email",
      //       context: context,
      //       type: ToastType.error);
      //   await user.sendEmailVerification();
      // }
    });
  }
}
