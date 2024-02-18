class product_cls {
  final int id;
  final String title;
  final String description;
  final String image;
  final double rating;
  final double price;
  int? pQuantity;

  product_cls({
    this.pQuantity,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });

  static List<product_cls> convertToprods(List p) {
    List<product_cls> prodList = [];
    for (var any in p) {
      if (any["id"] != null ||
          any["title"] != null ||
          any["content"] != null ||
          any["title"] != null ||
          any["rating"] != null ||
          any["price"] != null) {
        prodList.add(
          product_cls(
            id: any["id"],
            title: any["title"],
            description: any["description"],
            image: any["images"][0],
            price: any["price"].toDouble(),
            rating: any["rating"].toDouble(),
          ),
        );
      }
    }
    return prodList;
  }
}
