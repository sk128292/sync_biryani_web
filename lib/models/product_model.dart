import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const CATEGORY = "category";
  static const DESCRIPTION = "description";
  static const AVAILABLE = "available";
  static const QTY = "unitQty";

  String _id;
  String _name;
  String _image;
  int _price;
  String _category;
  String _description;
  bool _available;
  int _unitQty;

  // getter

  String get id => _id;
  String get name => _name;
  String get image => _image;
  String get category => _category;
  String get description => _description;
  int get price => _price;
  int get unitQty => _unitQty;
  bool get featured => _available;

  // bool featured = _featured;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _category = snapshot.data()[CATEGORY];
    _description = snapshot.data()[DESCRIPTION];
    _price = snapshot.data()[PRICE];
    _unitQty = snapshot.data()[QTY];
    _available = snapshot.data()[AVAILABLE];
  }
}
