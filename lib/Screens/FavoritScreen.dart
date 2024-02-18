import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data_provider/local/sqflite.dart';
import '../model/product.dart';
import 'CartScreen.dart';
import 'ProductDetailsScreen.dart';
import 'drawer.dart';
import '../model/productFav.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreen();
}

class _FavoriteScreen extends State<FavoriteScreen> {
  Sqflite sqlDb = Sqflite();
  bool isDarkModeEnabled = false;
  final user = FirebaseAuth.instance.currentUser;

  List<product_cls> product = [];
  bool isLoading = true;
  myReadData() async {
    //List<Map> response = await sqlDb.readData('SELECT * FROM note');
    // Shortcut
    List<Map> response = await sqlDb.myRead('favoriteprod');
    print("ffffffffffffffffffffffffff");
    product = product_clsFav.convertToprodsFav(response);
    print("dddddddddddddddddddddddddd");
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    myReadData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('ShopApp'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(

              icon: const Icon(

                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
            )
          ],
        ),
        drawer: drawer(),
        //   The Products

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [

              SizedBox(height: 5),

              Container(
                width: 360,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0,1),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Favourites',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: width,
                    height: height - 120,
                    child: GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Set the number of columns
                        crossAxisSpacing:
                        10.0, // Set the spacing between columns
                        mainAxisSpacing:
                        10.0, // Set the spacing between rows
                      ),
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    product: product[index]),
                              ),
                            );
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    product[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    product[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.money,
                                        color: Colors.green,
                                        size: 16,
                                      ),

                                      Text(
                                        '\$${product[index].price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.favorite),
                                        color: Colors.red,
                                        onPressed: () async{
                                          await sqlDb.myDelete('favoriteprod',"productid = ${product[index].id}");
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
