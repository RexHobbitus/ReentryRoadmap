import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseCollection{

  ///
  FirebaseAuth  get auth => FirebaseAuth.instance;
  FirebaseFirestore  get firestore => FirebaseFirestore.instance;

  /// collections
  final usersCollection=FirebaseFirestore.instance.collection('users');
  final providersCollection=FirebaseFirestore.instance.collection('providers');
  final checkInCollection=FirebaseFirestore.instance.collection('checkIns');
  final ceoCollection=FirebaseFirestore.instance.collection('ceo');
  final featuredProvidersOurTakeCollection=FirebaseFirestore.instance.collection('featuredProvidersOurTake');





}