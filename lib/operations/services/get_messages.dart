import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getMessages({required String currentUserId, required String recipientId}) {
  CollectionReference messagesRef = FirebaseFirestore.instance.collection('messages');
  if (currentUserId == 'a0wffzdqn9ZF8rIWSS7yzgmzjtx2') {
    print('Right hre');
    return messagesRef.where('recipientId', isEqualTo: currentUserId).snapshots();
  }
  print('Got to 2nd rtn');
  return messagesRef.where('parties', arrayContains: currentUserId).orderBy('timestamp').snapshots();
}

// .where('senderId', arrayContains: [currentUserId,recipientId])