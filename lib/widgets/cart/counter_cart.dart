import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/services/cart_service.dart';

class CounterForCart extends StatefulWidget {
  final DocumentSnapshot document;
  final String docId;
  final int unitQty;
  CounterForCart({this.document, this.unitQty, this.docId});

  @override
  _CounterForCartState createState() => _CounterForCartState();
}

class _CounterForCartState extends State<CounterForCart> {
  User user = FirebaseAuth.instance.currentUser;
  CartService _cartService = CartService();

  int _unitQty;
  String _docId;
  bool _exists = false;
  bool _updating = false;

  getCartData() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(user.uid)
        .collection('products')
        .where('productId', isEqualTo: widget.document.data()['productId'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          if (doc['productId'] == widget.document.data()['productId']) {
            setState(() {
              _unitQty = doc['unitQty'];
              _docId = doc.id;
              _exists = true;
            });
          }
        });
      } else {
        setState(() {
          _exists = false;
        });
      }
    });
  }

  @override
  void initState() {
    getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);

    return _exists
        ? StreamBuilder(
            stream: getCartData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange[400],
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _updating = true;
                          });
                          if (_unitQty == 1) {
                            _cartService.removeFromCart(_docId).then((value) {
                              setState(() {
                                _updating = false;
                                _exists = false;
                              });
                              // need to check after remove
                              _cartService.checkData();
                            });
                          }
                          if (_unitQty > 1) {
                            setState(() {
                              _unitQty--;
                            });
                            var total =
                                _unitQty * widget.document.data()['price'];
                            _cartService
                                .updateCartQty(_docId, _unitQty, total)
                                .then((value) {
                              setState(() {
                                _updating = false;
                              });
                            });
                          }
                        },
                        child: Container(
                          child: _unitQty == 1
                              ? Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                )
                              : Icon(Icons.remove, color: Colors.red),
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        width: 30,
                        color: Colors.orange[400],
                        child: Center(
                          child: FittedBox(
                            child: _updating
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    _unitQty.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _updating = true;
                            _unitQty++;
                          });
                          var total =
                              _unitQty * widget.document.data()['price'];
                          _cartService
                              .updateCartQty(_docId, _unitQty, total)
                              .then((value) {
                            setState(() {
                              _updating = false;
                            });
                          });
                          _user.reloadUserModel();
                        },
                        child: Container(
                          child: Icon(Icons.add, color: Colors.orange[400]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
        : Container(
            height: 28,
            decoration: BoxDecoration(
              color: Colors.orange[400],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ),
          );
  }
}
