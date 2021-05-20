import 'package:cloud_firestore/cloud_firestore.dart';

class NewProductServices {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
}
