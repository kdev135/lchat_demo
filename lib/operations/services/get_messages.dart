import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getMessages({required String currentUserId, required String recipientId}) {
  CollectionReference messagesRef = FirebaseFirestore.instance.collection('messages');
  return messagesRef
.orderBy('timestamp').snapshots();
}

