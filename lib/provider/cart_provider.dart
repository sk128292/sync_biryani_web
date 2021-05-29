import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sync_biryani_web/services/cart_service.dart';

class CartProvider with ChangeNotifier {
  CartService _cartService = CartService();
  double subTotal = 0.0;
  int cartQty = 0;
  QuerySnapshot snapshot;
  double saving = 0.0;
  bool cod = false;

  CartProvider.initialize() {
    getCartTotal();
  }

  Future<double> getCartTotal() async {
    var cartTotal = 0.0;
    var saving = 0.0;

    QuerySnapshot snapshot = await _cartService.cart
        .doc(_cartService.user.uid)
        .collection('products')
        .get();
    if (snapshot == null) {
      return null;
    }
    snapshot.docs.forEach((doc) {
      cartTotal = cartTotal + doc.data()['total'];
      saving = saving +
          (((doc.data()['comparedPrice'] * doc.data()['unitQty']) -
                      doc.data()['total']) >
                  0
              ? ((doc.data()['comparedPrice'] * doc.data()['unitQty']) -
                  doc.data()['total'])
              : 0);
    });

    this.subTotal = cartTotal;
    this.cartQty = snapshot.size;
    this.snapshot = snapshot;
    this.saving = saving;

    notifyListeners();

    return cartTotal;
  }

  getPaymentMethod(index) {
    if (index == 0) {
      this.cod = false;
      notifyListeners();
    } else {
      this.cod = true;
      notifyListeners();
    }
  }
}
