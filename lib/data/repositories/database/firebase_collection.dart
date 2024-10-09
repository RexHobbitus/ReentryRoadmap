import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseCollection{

  ///
  FirebaseAuth  get auth => FirebaseAuth.instance;
  FirebaseFirestore  get firestore => FirebaseFirestore.instance;

  /// collections
  final usersCollection=FirebaseFirestore.instance.collection('users');

}