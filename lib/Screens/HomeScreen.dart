
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'CartScreen.dart';
import 'ProductDetailsScreen.dart';
import '../model/product.dart';
import '../data_provider/local/sqflite.dart';
import 'drawer.dart';

class ApiConstants {
  static const String api = "https://dummyjson.com/products";
}

class DioHelper {
  final Dio dio = Dio();
  Future<List> getNews({required String path}) async {
    Response response = await dio.get(path);
    return response.data["products"];
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Sqflite sqlDb = Sqflite();
  int indexValue = 0;
  bool isDarkModeEnabled = false;
  final user = FirebaseAuth.instance.currentUser;
  List<product_cls> product = [];

  Future<void> getData() async {
    List prodList = await DioHelper().getNews(path: ApiConstants.api);
    product = product_cls.convertToprods(prodList);
    setState(() {});
  }

  //for product api
  @override
  void initState() {
    super.initState();
    getData();
  }
  bool isSlected =false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<bool> isFavoriteList = List.generate(product.length, (index) => false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
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

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),

          ],
        ),
        drawer: drawer(),
        //   The Products

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10),
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
                    'Trending',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Carousel(
                height: 200,
                indicatorBarColor: Colors.black.withOpacity(0),
                autoScrollDuration: Duration(seconds: 2),
                animationPageDuration: Duration(milliseconds: 500),
                activateIndicatorColor: Colors.amber.shade900,
                indicatorBarHeight: 25,
                indicatorHeight: 10,
                indicatorWidth: 15,
                unActivatedIndicatorColor: Colors.grey,
                autoScroll: true,
                items: [
                  Container(
                    child: Image.asset(
                      'assets/images/bts.jpg',
                      height: 500,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/watch.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/sales.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),


              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: width,
                    height: height - 120,
                    child: product.length == 0
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          )
                        : GridView.builder(
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
                                              color:isFavoriteList[index] ? Colors.red : Colors.grey,
                                              onPressed: () async {
                                                await sqlDb
                                                    .myInsert('favoriteprod', {
                                                  "productid":
                                                      (index + 1).toInt(),
                                                  "username":
                                                      (user!.email!).toString(),
                                                  "title": product[index].title,
                                                  "description":
                                                      product[index].description,
                                                  "image": product[index]
                                                      .image
                                                      .toString(),
                                                  "rating": product[index].rating,
                                                  "price": product[index].price
                                                });
                                                setState(() { isFavoriteList[index] = !isFavoriteList[index];});
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
