import 'package:sync_biryani_web/models/category_model.dart';
import 'package:sync_biryani_web/services/category_services.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];

  CategoryProvider.initialize() {
    loadCategories();
  }

  loadCategories() async {
    print("sandeep kumar");
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }
}
