import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/services/cart_service.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';
import 'package:sync_biryani_web/widgets/second_screen_widget/counter_widget.dart';

class AddToCartWidget extends StatefulWidget {
  final DocumentSnapshot documnet;
  AddToCartWidget(this.documnet);

  @override
  _AddToCartWidgetState createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget> {
  CartService _cartService = CartService();

  User user = FirebaseAuth.instance.currentUser;
  bool _loading = true;
  bool _exist = false;
  int _unitQty = 1;
  String _docId;

  @override
  void initState() {
    getCartData(); // while opening product Screen
    super.initState();
  }

  getCartData() async {
    final snapshot =
        await _cartService.cart.doc(user.uid).collection('products').get();
    if (snapshot.docs.isEmpty) {
      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);
    FirebaseFirestore.instance
        .collection('cart')
        .doc(user.uid)
        .collection('products')
        .where('productId', isEqualTo: widget.documnet.data()['id'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          if (doc['productId'] == widget.documnet.data()['id']) {
            setState(() {
              _exist = true;
              _unitQty = doc['unitQty'];
              _docId = doc.id;
            });
          }
          return;
        });
      } else {
        setState(() {
          _exist = false;
        });
      }
    });
    return _loading
        ? Container(
            height: MediaQuery.of(context).size.width * 0.02,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
          )
        : _exist
            ? CounterWidget(
                snapshot: widget.documnet, unitQty: _unitQty, docId: _docId)
            : MaterialButton(
                color: Colors.red[400],
                onPressed: () {
                  EasyLoading.show(status: 'Adding to Cart');
                  _cartService.addToCartNew(widget.documnet).then(
                    (value) {
                      setState(() {
                        _exist = true;
                      });
                      EasyLoading.showSuccess('Added Successfully');
                      _user.reloadUserModel();
                    },
                  );
                },
                child: Text(
                  "Add To Cart",
                  style: TextStyle(
                    fontSize: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width / 85
                        : MediaQuery.of(context).size.width * 0.025,
                    color: Colors.white,
                  ),
                ),
              );
  }
}
