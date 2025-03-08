import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionService {
  static final CollectionService _instance = CollectionService._internal();
  CollectionService._internal();
  factory CollectionService() => _instance;

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Collections
  static final UICollection = firestore.collection('ui_screens');
  static final ColorsCollection = firestore.collection('Colors');
  static final UserCollection = firestore.collection('Users');
  static final VehicleCollection = firestore.collection('Vehicles');
}
