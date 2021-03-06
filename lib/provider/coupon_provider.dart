import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CouponProvider with ChangeNotifier {
  CouponProvider.initialize();
  bool expired;
  String title = '';
  String details = '';
  int discountRate = 0;

  Future<DocumentSnapshot> getCouponDetails(title) async {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('coupons').doc(title).get();
    if (document.exists) {
      checkExpiry(document);
    }
    return document;
  }

  checkExpiry(DocumentSnapshot document) {
    DateTime date = document.data()['expiry'].toDate();
    var dateDiff = date.difference(DateTime.now()).inDays;
    if (dateDiff < 0) {
      //Coupon Expired
      this.expired = true;
      notifyListeners();
    } else {
      this.title = document.data()['title'];
      this.details = document.data()['details'];

      this.expired = false;
      this.discountRate = document.data()['discountRate'];
      notifyListeners();
    }
  }
}
