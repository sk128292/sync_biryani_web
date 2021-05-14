import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sync_biryani_web/services/cart_service.dart';

class CounterWidget extends StatefulWidget {
  final DocumentSnapshot snapshot;
  CounterWidget(this.snapshot);
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  CartService _cartService = CartService();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
