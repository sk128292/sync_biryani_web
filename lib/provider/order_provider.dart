import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
  OrderProvider.initialize();
  String status;

  filterOrder(status) {
    this.status = status;
    notifyListeners();
  }
}
