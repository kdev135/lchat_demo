import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lchat/components/logout_button.dart';
import 'package:lchat/operations/services/get_messages.dart';
import 'dart:convert';

import '../models/ui_models/text_field_model.dart';
import '../operations/services/send_message.dart';
import 'home_screen.dart';
import 'login_screen.dart';

final List<String> adminAccounts = [
  'VXkSEzeaW1Ulw9GWhtfyhk6FHvA3',
  'RUU4uq2qsZTHFny2XTZIWRkDkYe2',
  'a0wffzdqn9ZF8rIWSS7yzgmzjtx2'
];

final FirebaseAuth auth = FirebaseAuth.instance;

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.recipientId});
  final String recipientId;

  late final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController messageTextController = TextEditingController();

  final admin_names = {
    'VXkSEzeaW1Ulw9GWhtfyhk6FHvA3': 'Accounts support agent',
    'RUU4uq2qsZTHFny2XTZIWRkDkYe2': 'Models support agent',
    'a0wffzdqn9ZF8rIWSS7yzgmzjtx2': 'General information support agent'
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                 
                ),
              ));
        }),
        title: const Text('L O N G E V I T Y  C H A T'),
        centerTitle: true,
        actions:const [
          LogoutButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Card(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Chatting with: ${ admin_names[recipientId] ?? recipientId}'),
            )),
            Expanded(
              child: SentMessages(
                currentUserId: currentUserId,
                recipientId: recipientId,
              ),
            ),
            Container(
              color: Colors.grey.shade100,
              margin: EdgeInsets.symmetric(horizontal: 05),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFieldModel(
                          textController: messageTextController,
                          hintText: 'Write a message',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.attach_file_sharp,
                              color: Colors.grey,
                            ),
                            tooltip: 'Attach a file',
                          ),
                        )),
                  ),
                  IconButton(
                      onPressed: () {
                        if (messageTextController.text.isNotEmpty) {
                          sendMessage(messageTextController.text, recipientId);
                          messageTextController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blueAccent,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Build a widget list of the messages
class SentMessages extends StatelessWidget {
  SentMessages({super.key, required this.currentUserId, required this.recipientId});

  late final String currentUserId;
  late final String recipientId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getMessages(currentUserId: currentUserId, recipientId: recipientId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        try {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
        } catch (e) {
          debugPrint('Something went wrong: $e');
        }
        final messages = snapshot.data!.docs;
        final mess = snapshot.data;
        print(mess);

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            final message = messages[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: BubbleNormal(
                text: message["message"],
                isSender: currentUserId == message["senderId"] ? true : false,
                color: currentUserId == message["senderId"] ? Colors.blue : Colors.grey.shade300,
                textStyle: currentUserId == message["senderId"]
                    ? const TextStyle(color: Colors.white, fontSize: 16)
                    : const TextStyle(color: Colors.black, fontSize: 16),
              ),
            );
          },
        );
      },
    );
  }
}
