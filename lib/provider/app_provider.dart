import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  int totalPrice = 0;
  int priceSum = 0;
  int qtySum = 0;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  addPrice({int newPrice}) {
    priceSum += newPrice;
    notifyListeners();
  }

  addQty({int newQty}) {
    qtySum += newQty;
    notifyListeners();
  }

  // getTotalPrice() {
  //   print("The total sum: $priceSum");
  //   print("The total sum: $priceSum");
  //   print("The total sum: $priceSum");

  //   print("The total qty: $qtySum");
  //   print("The total qty: $qtySum");
  //   print("The total qty: $qtySum");

  //   totalPrice = priceSum * qtySum;
  //   notifyListeners();
  // }
}
