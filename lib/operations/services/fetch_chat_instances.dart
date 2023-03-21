
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
Stream<QuerySnapshot> fetchChatInstances() {
  CollectionReference messagesRef = FirebaseFirestore.instance.collection('messages');
  return messagesRef.where('recipientId', isEqualTo: auth.currentUser!.uid).orderBy('timestamp').snapshots();
}
