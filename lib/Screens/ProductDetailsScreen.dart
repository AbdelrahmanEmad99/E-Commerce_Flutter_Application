import '../provider/cartItem.dart';
import 'CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import '/model/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final product_cls product;
  ProductDetailsScreen({required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('ShopApp'),


      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Text(
                  widget.product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      widget.product.rating.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 200),
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.redAccent,
                        child: GestureDetector(
                          onTap: add,
                          child: SizedBox(
                            child: Icon(Icons.add),
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _quantity.toString(),
                      style: TextStyle(fontSize: 60),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.redAccent,
                        child: GestureDetector(
                          onTap: subtract,
                          child: SizedBox(
                            child: Icon(Icons.remove),
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Builder(builder: (context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .08,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        addToCart(context, widget.product);
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: Text('Add to Cart'.toUpperCase()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          textStyle:
                              TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  subtract() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.allproducts;
    for (var productInCart in productsInCart) {
      if (productInCart.title == product.title) {
        exist = true;
      }
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('you\'ve added this item before'),
      ));
    } else {
      cartItem.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Added to Cart'),
      ));
    }
  }
}
