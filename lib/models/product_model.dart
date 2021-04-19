// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductModel {
//   static const ID = "id";
//   static const NAME = "name";
//   static const IMAGE = "image";
//   static const PRICE = "price";
//   static const CATEGORY = "category";
//   static const FEATURED = "featured";
//   static const QTY = "qty";

//   int _id;
//   String _name;
//   String _image;
//   int _price;
//   String _category;
//   bool _featured;
//   int _qty;

//   // getter

//   int get id => _id;
//   String get name => _name;
//   String get image => _image;
//   String get category => _category;
//   int get price => _price;
//   int get qty => _qty;
//   bool get featured => _featured ?? false;

//   // bool featured = _featured;

//   ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
//     _id = snapshot.data()[ID];
//     _name = snapshot.data()[NAME];
//     _image = snapshot.data()[IMAGE];
//     _category = snapshot.data()[CATEGORY];
//     _price = snapshot.data()[PRICE];
//     _qty = snapshot.data()[QTY];
//     _featured = snapshot.data()[FEATURED];
//   }
// }
