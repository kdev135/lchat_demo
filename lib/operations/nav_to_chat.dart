import 'package:flutter/Material.dart';
import 'package:lchat/screens/chat_screen.dart';

void navToChat(context,{ required String recipientId,}){
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ChatScreen(recipientId: recipientId,),
  ),
);
}