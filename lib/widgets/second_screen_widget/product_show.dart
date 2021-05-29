import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sync_biryani_web/services/product_services.dart';
import 'package:sync_biryani_web/widgets/second_screen_widget/product_card_widget.dart';

class ProductDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductServices _productServices = ProductServices();

    return FutureBuilder<QuerySnapshot>(
      future: _productServices.products.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.docs.isEmpty) {
          return Container(); // if no data available
        }

        return new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // shrinkWrap: true,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return ProductCard(document);
          }).toList(),
        );
      },
    );
  }
}
