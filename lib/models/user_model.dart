import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sync_biryani_web/models/cart_item_model.dart';

class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "id";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String _name;
  String _email;
  String _id;
  String _stripeId;
  int _priceSum = 0;
  // int _qtySum = 0;

  // Getters

  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;

// public variable

  List cart = [];
  int totalCartAmount;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _id = snapshot.data()[ID];
    _stripeId = snapshot.data()[STRIPE_ID];
    cart = snapshot.data()[CART] ?? [];
    // totalCartAmount = getTotalAmount(cart: snapshot.data()[CART]) ?? [];
  }

  int getTotalAmount({List cart}) {
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"] * cartItem["qty"];
    }

    int total = _priceSum;

    print("the Total is: $total");

    return total;
  }

  List<CartItemModel> _convertCartItems(List<Map> cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
