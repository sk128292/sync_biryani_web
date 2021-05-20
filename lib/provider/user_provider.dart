import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sync_biryani_web/models/order_model.dart';
import 'package:sync_biryani_web/models/product_model.dart';
import 'package:sync_biryani_web/models/user_model.dart';
import 'package:sync_biryani_web/services/order_services.dart';
import 'package:sync_biryani_web/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

  // getters

  Status get status => _status;
  UserModel get userModel => _userModel;
  User get user => _user;
  // public variables

  List<OrderModel> orders = [];

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanges);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<void> signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((result) {
        _firestore.collection('users').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
          "likedProduct": []
        });
      });
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<void> _onAuthStateChanges(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(user.uid);
    }
    notifyListeners();
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  // general Methods..

  bool _onError(String error) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print(" We got an error $error");
    return false;
  }

  void cleanControllers() {
    email.text = "";
    password.text = "";
    name.text = "";
  }

  Future<bool> addToCart({ProductModel product}) async {
    print("The Product Is : ${product.toString()} ");
    // print("The Qty Is : ${unitQty.toString()} ");
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = _userModel.cart;
      bool itemExists = false;
      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "productId": product.id,
        "price": product.price,
        "unitQty": product.unitQty,
      };
      for (Map item in cart) {
        if (item["productId"] == cartItem["productId"]) {
          // item["qty"] = item["qty"] + qty;
          itemExists = true;
          print("The items are already exist in cart");
          break;
        }
      }
      if (!itemExists) {
        print("Cart Items Are : ${cart.toString()}");
        _userServices.addToCart(userId: _user.uid, cartItem: cartItem);
      }

      return true;
    } catch (e) {
      print("The error ${e.toString()}");
      return false;
    }
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({Map cartItem}) async {
    print("The Product Is : ${cartItem.toString()} ");
    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);

      return true;
    } catch (e) {
      print("The error ${e.toString()}");
      return false;
    }
  }
}
