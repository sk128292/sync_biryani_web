import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:sync_biryani_web/provider/product_provider.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    print("Total No of Products = " + productProvider.products.toString());
    return SingleChildScrollView(
      child: Responsive.isDesktop(context)
          ? Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                children: [
                  Text(productProvider.products.toString()),
                  Card(
                    // color: Colors.grey[300],
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5.8,
                          height: MediaQuery.of(context).size.width / 7,
                          child: Image.asset('images/a.jpg', fit: BoxFit.fill),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3.7,
                          height: MediaQuery.of(context).size.width / 7,
                          // color: Colors.lightBlue,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("HYDERABAD-E-KHAS",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[700],
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              70,
                                    )),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        "Hyderabadi Dum Gosht [Mutton Biryani, Boneless - Serves 1]",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              85,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                ReadMoreText(
                                  "Inspired by the Hyderabadi Style, tender mutton pieces are laid on long-grain rice are slow cooked to create a special delicacy [Spicy and Boneless, Served with 1 Gulab Jamun & Mint Raita]",
                                  // trimLength: 2,
                                  trimLength: 120,
                                  trimMode: TrimMode.Length,
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
                                    Text("250"),
                                    MaterialButton(
                                      color: Colors.red[400],
                                      onPressed: () {},
                                      child: Text(
                                        "Add To Cart",
                                        style: TextStyle(color: Colors.white),
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
                  ),
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Card(
                    // color: Colors.grey[300],
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3.4,
                          height: MediaQuery.of(context).size.width / 4,
                          child: Image.asset('images/a.jpg', fit: BoxFit.fill),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.6,
                          height: MediaQuery.of(context).size.width / 4,
                          // color: Colors.lightBlue,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                AutoSizeText("HYDERABAD-E-KHAS",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[700],
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              70,
                                    )),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        "Hyderabadi Dum Gosht [Mutton Biryani, Boneless - Serves 1]",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              85,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                ReadMoreText(
                                  "Inspired by the Hyderabadi Style, tender mutton pieces are laid on long-grain rice are slow cooked to create a special delicacy [Spicy and Boneless, Served with 1 Gulab Jamun & Mint Raita]",
                                  // trimLength: 2,
                                  trimLength: 120,
                                  trimMode: TrimMode.Length,
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
                                    Text("250"),
                                    MaterialButton(
                                      color: Colors.red[400],
                                      onPressed: () {},
                                      child: Text(
                                        "Add To Cart",
                                        style: TextStyle(color: Colors.white),
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
                  ),
                ],
              ),
            ),
    );
  }
}
