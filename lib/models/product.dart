class Product {
  final int productId;
  final String productTitle;
  final String productImage;
  final String productName;
  final int productPrice;
  final String productAbout;
  final String productSpecifications;
  int quantity;
  bool inCart;

  Product({required this.productId, required this.productTitle,
    required this.productImage, required this.productName,
    required this.productPrice, required this.productAbout,
    required this.productSpecifications, this.quantity = 0,
    this.inCart = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': productId,
      'Title': productTitle,
      'ImageURL': productImage,
      'Name': productName,
      'Price': productPrice,
      'Description': productAbout,
      'Specifications': productSpecifications,
      'Quantity': quantity,
      'InCart': inCart,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      productId: json['ID'],
      productTitle: json['Title'],
      productImage: json['ImageURL'],
      productName: json['Name'],
      productPrice: json['Price'],
      productAbout: json['Description'],
      productSpecifications: json['Specifications'],
      quantity: json['Quantity'],
      inCart: json['InCart'],
    );
  }
}