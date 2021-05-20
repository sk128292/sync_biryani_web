import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  User user = FirebaseAuth.instance.currentUser;

  Future<void> addToCartNew(document) {
    cart.doc(user.uid).set({
      'user': user.uid,
      'name': user.email,
    });

    print('nothing going');
    return cart.doc(user.uid).collection("products").add({
      'productId': document.data()['id'],
      'name': document.data()['name'],
      'unitQty': document.data()['unitQty'],
      'price': document.data()['price'],
      // 'qty': 1,
    }).then((value) {
      print("Hi");
    });
  }

  Future<void> updateCartQty(docId, unitQty) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(user.uid)
        .collection('products')
        .doc(docId);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          // Get the document
          DocumentSnapshot snapshot = await transaction.get(documentReference);

          if (!snapshot.exists) {
            throw Exception("Product does not exist in Cart !");
          }

          // Perform an update on the document
          transaction.update(documentReference, {'unitQty': unitQty});

          // Return the new count
          return unitQty;
        })
        .then((value) => print("Updated Cart "))
        .catchError((error) => print("Failed to update Cart: $error"));
  }
}
