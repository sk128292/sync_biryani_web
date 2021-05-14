// import 'dart:html';

// import 'dart:ffi';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');

  User user = FirebaseAuth.instance.currentUser;

  Future<dynamic> addToCartNew(document) {
    cart.doc(user.uid).set({
      'user': user.uid,
      'name': user.email,
    });

    print('nothing going');
    return cart.doc(user.uid).collection('product').add({
      'productId': document.data()['ProductId'],
      'name': document.data()['name'],
      'unitQty': document.data()['unitQty'],
      'price': document.data()['price'],
      // 'qty': 1,
    });
  }
}
