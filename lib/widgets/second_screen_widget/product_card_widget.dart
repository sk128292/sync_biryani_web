import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';
import 'package:sync_biryani_web/widgets/second_screen_widget/add_to_cart_widget.dart';

class ProductCard extends StatelessWidget {
  final DocumentSnapshot documnet;
  ProductCard(this.documnet);

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Container(
            width: MediaQuery.of(context).size.width / 1.8,
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 5.5,
                        height: MediaQuery.of(context).size.width / 7,
                        child: Material(
                          elevation: 5,
                          child: Image.network(
                            documnet.data()['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.8,
                        height: MediaQuery.of(context).size.width / 7,
                        // color: Colors.lightBlue,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(documnet.data()['category'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[700],
                                    fontSize:
                                        MediaQuery.of(context).size.width / 70,
                                  )),
                              RichText(
                                text: TextSpan(
                                  text: documnet.data()['name'],
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 85,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              ReadMoreText(
                                documnet.data()['description'],
                                // trimLength: 2,
                                trimLength: 120,
                                trimMode: TrimMode.Length,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 90,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rs: " +
                                        (documnet.data()['price'].toString()),
                                    style: TextStyle(
                                      color: Colors.orange[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Qty: " +
                                        (documnet.data()['unitQty'].toString()),
                                    style: TextStyle(
                                      color: Colors.orange[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  AddToCartWidget(documnet)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 5),
              ],
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.25,
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.22,
                        child: Material(
                          elevation: 5,
                          child: Image.network(
                            documnet.data()['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width / 1.51,
                        height: MediaQuery.of(context).size.width * 0.22,
                        // color: Colors.lightBlue,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(documnet.data()['category'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[700],
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.024,
                                  )),
                              RichText(
                                text: TextSpan(
                                  text: documnet.data()['name'],
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.0215,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              ReadMoreText(
                                documnet.data()['description'],
                                // trimLength: 2,
                                trimLength: 120,
                                trimMode: TrimMode.Length,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rs: " +
                                        (documnet.data()['price'].toString()),
                                    style: TextStyle(
                                      color: Colors.orange[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Qty: " +
                                        (documnet.data()['unitQty'].toString()),
                                    style: TextStyle(
                                      color: Colors.orange[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.025,
                                  ),
                                  AddToCartWidget(documnet)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 5),
              ],
            ),
          );
  }
}
