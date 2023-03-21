import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Send message to firebase. Parameters are [message] and [recipientId]
Future<void> sendMessage(String message, String recipientId) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final currentUserId = currentUser!.uid;
  // final currentUserName = currentUser.displayName;
  CollectionReference messagesRef = FirebaseFirestore.instance.collection('messages');

  await messagesRef.add({
    'senderId': currentUserId,
    
    'recipientId': recipientId,
    'message': message,
    'timestamp': FieldValue.serverTimestamp(),
    'parties': [currentUserId, recipientId]
  });
}