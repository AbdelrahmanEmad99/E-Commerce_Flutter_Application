import 'dart:ui';
import '/model/product.dart';
import 'ProductDetailsScreen.dart';
import '/provider/cartItem.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<product_cls> products = Provider.of<CartItem>(context).allproducts;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('ShopApp'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          LayoutBuilder(builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight -
                    statusBarHeight -
                    appBarHeight -
                    (screenHeight * .08),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showCustomMenu(details, context, products[index]);
                        },
                        child: InkWell(
                          child: Container(
                            height: screenHeight * .15,
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: screenHeight * .15 / 2,
                                  backgroundImage:
                                      NetworkImage(products[index].image),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              products[index].title,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '\$ ${products[index].price}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                height: screenHeight -
                    (screenHeight * .08) -
                    appBarHeight -
                    statusBarHeight,
                child: Center(
                  child: Text('Cart is Empty'),
                ),
              );
            }
          }),

           Expanded(
             child: Container(
              child: Align(
                alignment: Alignment.center,

                child: Text(
                  'Total Price: \$${getTotalPrice(products)}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ),
           ),
          //
          //

        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
      items: [
        PopupMenuItem(
          onTap: () {
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
            setState(() {});
          },
          child: Text('Delete'),
        ),
      ],
    );
  }

  double getTotalPrice(List<product_cls> product) {
    double price = 0;
    for (var p in product) {
      price += p.pQuantity! * p.price;
    }
    return price;
  }
}
