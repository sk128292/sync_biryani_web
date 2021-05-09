import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:sync_biryani_web/models/product_model.dart';
import 'package:sync_biryani_web/models/user_model.dart';
import 'package:sync_biryani_web/provider/app_provider.dart';
import 'package:sync_biryani_web/provider/product_provider.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/services/user_services.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';

class Products extends StatefulWidget {
  // final ProductModel productModel;
  // final UserModel userModel;

  // const Products({Key key, this.userModel}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  UserModel _userModel;
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getCartData();
    super.initState();
  }

  getCartData() {
    List cart = _userModel.cart;
  }

  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);
    return SingleChildScrollView(
      key: _key,
      primary: false,
      child: Responsive.isDesktop(context)
          ? Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: productProvider.products.length,
                    itemBuilder: (_, index) {
                      return Card(
                        // color: Colors.grey[300],
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5.8,
                              height: MediaQuery.of(context).size.width / 7,
                              child: Image.network(
                                  productProvider.products[index].image,
                                  fit: BoxFit.fill),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3.7,
                              height: MediaQuery.of(context).size.width / 7,
                              // color: Colors.lightBlue,
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                        productProvider
                                            .products[index].category,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange[700],
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              70,
                                        )),
                                    RichText(
                                      text: TextSpan(
                                        text: productProvider
                                            .products[index].name,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              85,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    ReadMoreText(
                                      productProvider
                                          .products[index].description,
                                      // trimLength: 2,
                                      trimLength: 120,
                                      trimMode: TrimMode.Length,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                90,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(productProvider
                                            .products[index].price),
                                        if (user.userModel.cart.contains(
                                            productProvider.products[index].id))
                                          MaterialButton(
                                            color: Colors.red[400],
                                            onPressed: () async {
                                              app.changeLoading();
                                              print("All set loading");
                                              bool value = await user.addToCart(
                                                  product: productProvider
                                                      .products[index],
                                                  qty: productProvider
                                                      .products[index].qty);
                                              if (value) {
                                                print("Item Added to cart");
                                                // ignore: deprecated_member_use
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content:
                                                        Text("Added to Cart"),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ),
                                                );
                                                user.reloadUserModel();
                                                app.changeLoading();
                                                return;
                                              } else {
                                                print("Item not Added to cart");
                                              }

                                              print("Loading set false");
                                            },
                                            child: Text(
                                              "Add To Cart",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    85,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        else
                                          Text("data")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: productProvider.products.length,
                      itemBuilder: (_, index) {
                        return Card(
                          // color: Colors.grey[300],
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                height: MediaQuery.of(context).size.width / 4,
                                child: Image.network(
                                    productProvider.products[index].image,
                                    fit: BoxFit.fill),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.7,
                                height: MediaQuery.of(context).size.width / 4,
                                // color: Colors.lightBlue,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      AutoSizeText(
                                          productProvider
                                              .products[index].category,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange[700],
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                45,
                                          )),
                                      RichText(
                                        text: TextSpan(
                                          text: productProvider
                                              .products[index].name,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                48,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      ReadMoreText(
                                        productProvider
                                            .products[index].description,
                                        // trimLength: 2,
                                        trimLength: 120,
                                        trimMode: TrimMode.Length,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              51,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // RichText(
                                      //   text: TextSpan(
                                      //     text:
                                      //         "Inspired by the Hyderabadi Style, tender mutton pieces are laid on long-grain rice are slow cooked to create a special delicacy [Spicy and Boneless, Served with 1 Gulab Jamun & Mint Raita]",
                                      //     style: TextStyle(
                                      //       fontSize:
                                      //           MediaQuery.of(context).size.width / 90,
                                      //       color: Colors.black,
                                      //     ),
                                      //   ),
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(productProvider
                                              .products[index].price),
                                          MaterialButton(
                                            color: Colors.red[400],
                                            onPressed: () {},
                                            child: Text(
                                              "Add To Cart",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
