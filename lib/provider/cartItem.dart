import '/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import '/model/product.dart';

class CartItem extends ChangeNotifier {
  List<product_cls> allproducts = [];

  addProduct(product_cls product) {
    allproducts.add(product);
    notifyListeners();
  }

  deleteProduct(product_cls product) {
    allproducts.remove(product);
    notifyListeners();
  }
}
