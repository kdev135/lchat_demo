import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lchat/components/logout_button.dart';
import 'package:lchat/operations/nav_to_chat.dart';
import 'package:lchat/operations/services/fetch_chat_instances.dart';

const String adminAccount = 'a0wffzdqn9ZF8rIWSS7yzgmzjtx2';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/lchat.png'),
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          actions: const [LogoutButton()],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              navToChat(context, recipientId: adminAccount);
            }),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ChatInstances(),
        ));
  }
}

class ChatInstances extends StatelessWidget {
  ChatInstances({super.key});
  final List senderIds = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fetchChatInstances(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        try {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
        } catch (e) {
          debugPrint('Something went wrong: $e');
        }
        final messages = snapshot.data!.docs;
        for (var msg in messages) {
          if (!senderIds.contains(msg['senderId'])) {
            senderIds.add(msg['senderId']);
          }
        }
        if (adminAccount == FirebaseAuth.instance.currentUser!.uid) {
          if (senderIds.isNotEmpty) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: senderIds.length,
              itemBuilder: (BuildContext context, int index) {
                final sender = senderIds[index];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        const Text('Conversation Id: '),
                        TextButton(
                            child: Text(sender),
                            onPressed: () {
                              navToChat(context, recipientId: sender.toString());
                            }),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text('Clent messages show here');
          }
        }

        return Column(
          children: [
            Expanded(flex: 1, child: Text('Logged in as: ${FirebaseAuth.instance.currentUser!.email}')),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    'Welcome to Longevity Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Tap on the + button below to initiate coversation',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
