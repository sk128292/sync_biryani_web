// import 'package:resto/models/product_model.dart';
// import 'package:resto/services/product_services.dart';
// import 'package:flutter/material.dart';

// class ProductProvider with ChangeNotifier {
//   ProductServices _productServices = ProductServices();
//   List<ProductModel> products = [];
//   List<ProductModel> productsByCategory = [];
//   List<ProductModel> productsSearched = [];

//   ProductProvider.initialize() {
//     loadProducts();
//   }

//   loadProducts() async {
//     products = await _productServices.getProducts();
//     notifyListeners();
//   }

//   Future loadProductsByCategory({String categoryName}) async {
//     productsByCategory =
//         await _productServices.getProductsOfCategory(category: categoryName);
//     notifyListeners();
//   }

//   Future search({String productName}) async {
//     productsSearched =
//         await _productServices.searchProducts(productName: productName);
//     notifyListeners();
//   }
// }
