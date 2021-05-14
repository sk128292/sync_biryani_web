import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sync_biryani_web/services/cart_service.dart';

class AddToCartWidget extends StatefulWidget {
  final DocumentSnapshot documnet;
  AddToCartWidget(this.documnet);
  @override
  _AddToCartWidgetState createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget> {
  CartService _cartService = CartService();
  User user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // getCartData(); // while opening product Screen
    super.initState();
  }

  getCartData() async {
    _cartService.cart.doc(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _cartService.addToCartNew(widget.documnet);
        },
        child: Container());
  }
}
