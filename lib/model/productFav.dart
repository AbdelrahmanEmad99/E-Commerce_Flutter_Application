import 'package:firebase_auth/firebase_auth.dart';
import 'product.dart';

class product_clsFav {
  final int id;
  final String title;
  final String description;
  final String image;
  final double rating;
  final double price;

  product_clsFav({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });

  static List<product_cls> convertToprodsFav(List p) {
    List<product_cls> prodList = [];
    final user = FirebaseAuth.instance.currentUser;
    for (var any in p) {
      if ((user!.email!).toString() == any["username"]) {

        prodList.add(
          product_cls(
            id: any["productid"],
            title: any["title"].toString(),
            description: any["description"].toString(),
            image: any["image"].toString(),
            price: any["price"].toDouble(),
            rating: any["rating"].toDouble(),
          ),
        );
      }
    }
    return prodList;
  }
}