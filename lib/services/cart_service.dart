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

    return cart.doc(user.uid).collection("products").add({
      'productId': document.data()['id'],
      'name': document.data()['name'],
      'unitQty': document.data()['unitQty'],
      'price': document.data()['price'],
      'comparedPrice': document.data()['comparedPrice'],
      'total': document.data()['price'],
    }).then((value) {
      print("Item Added to Cart");
    });
  }

  Future<void> updateCartQty(docId, unitQty, total) async {
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
          transaction
              .update(documentReference, {'unitQty': unitQty, 'total': total});

          // Return the new count
          return unitQty;
        })
        .then((value) => print("Updated Cart "))
        .catchError((error) => print("Failed to update Cart: $error"));
  }

  Future<void> removeFromCart(docId) async {
    cart.doc(user.uid).collection('products').doc(docId).delete();
  }

  Future<void> checkData() async {
    final snapshot = await cart.doc(user.uid).collection('products').get();
    if (snapshot.docs.length == 0) {
      cart.doc(user.uid).delete();
    }
  }

  Future<void> deleteCart() async {
    final result =
        await cart.doc(user.uid).collection('products').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    return result;
  }
}
