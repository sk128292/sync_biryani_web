import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTALAMOUNT = "totalAmount";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String _id;
  String _description;
  String _userId;
  String _status;
  int _createdAt;
  int _totalAmount;

  // public variable
  List cart;

  // getters

  String get id => _id;
  String get description => _description;
  String get userId => _userId;
  String get status => _status;
  int get totalAmount => _totalAmount;
  int get cratedAt => _createdAt;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.get(ID);
    _description = snapshot.get(DESCRIPTION);
    _userId = snapshot.get(USER_ID);
    _status = snapshot.get(STATUS);
    _totalAmount = snapshot.get(TOTALAMOUNT);
    _createdAt = snapshot.get(CREATED_AT);
    cart = snapshot.get(CART);
  }
}
