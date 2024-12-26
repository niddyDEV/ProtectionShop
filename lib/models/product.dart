class Product {
  final int productId;
  final String productTitle;
  final String productImage;
  final String productName;
  final int productPrice;
  final String productAbout;
  final String productSpecifications;
  int quantity;
  bool isFavorite;
  bool inCart;

  Product({required this.productId, required this.productTitle,
    required this.productImage, required this.productName,
    required this.productPrice, required this.productAbout,
    required this.productSpecifications, this.quantity = 0,
    this.isFavorite = false, this.inCart = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'title': productTitle,
      'image_url': productImage,
      'name': productName,
      'price': productPrice,
      'description': productAbout,
      'specifications': productSpecifications,
      'quantity': quantity,
      'is_favourite' : isFavorite,
      'in_cart': inCart,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['id'] ?? 0,
      productTitle: json['title'] ?? '',
      productImage: json['image_url'] ?? '',
      productName: json['name'] ?? '',
      productPrice: json['price'] ?? 0,
      productAbout: json['description'] ?? '',
      productSpecifications: json['specifications'] ?? '',
      quantity: json['quantity'] ?? 0,
      isFavorite: json['is_favourite'] ?? false,
      inCart: json['in_cart'] ?? false,
    );
  }
}