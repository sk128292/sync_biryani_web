import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sync_biryani_web/widgets/cart/counter_cart.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';

class CartCard extends StatelessWidget {
  final DocumentSnapshot document;
  CartCard(this.document);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // width: MediaQuery.of(context).size.width / 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: document.data()['name'],
                                  // "Hyderabadi Dum Gosht [Mutton Biryani, Boneless - Serves 1]",
                                  style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? MediaQuery.of(context).size.width / 84
                                        : MediaQuery.of(context).size.width *
                                            0.022,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Rs. ' +
                                        document
                                            .data()['comparedPrice']
                                            .toString(),
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    "Rs: " +
                                        (document.data()["price"]).toString() +
                                        " X " +
                                        document.data()["unitQty"].toString(),
                                  ),

                                  // Text(
                                  //   "Rs: " + (document.data()["price"]).toString(),
                                  //   style: TextStyle(
                                  //       color: Colors.orange[700],
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        CounterForCart(
                          document: document,
                          docId: document.id,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width / 80),
                    Row(
                      children: [
                        Text(
                          "Rs: " + document.data()['total'].toString(),
                          style: TextStyle(
                              color: Colors.orange[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(4),
            //   child: Divider(
            //     thickness: 1,
            //     color: Colors.grey,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
