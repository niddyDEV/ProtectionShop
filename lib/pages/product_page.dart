import 'package:flutter/material.dart';
import 'package:prk3_3_3/models/product.dart';
import 'package:prk3_3_3/models/favorite_manager.dart';
import 'package:provider/provider.dart';
import 'package:prk3_3_3/models/cart_manager.dart';
import 'package:badges/badges.dart' as badges;
import 'package:prk3_3_3/models/product_manager.dart';
import 'package:prk3_3_3/pages/edit_product_page.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);
    final cartManager = Provider.of<CartManager>(context);
    final productManager = Provider.of<ProductManager>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(500, 237, 231, 246),
      appBar: AppBar(
        title: Text(widget.product.productTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              favoriteManager.isFavorite(widget.product) ? Icons.favorite : Icons.favorite_border,
              color: favoriteManager.isFavorite(widget.product) ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              if (favoriteManager.isFavorite(widget.product)) {
                favoriteManager.removeFromFavorite(widget.product);
              } else {
                favoriteManager.addToFavorite(widget.product);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await productManager.removeProduct(widget.product.productId); // Удаляем продукт через API
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit), // Кнопка редактирования
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductPage(product: widget.product), // Переходим на страницу редактирования
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              widget.product.productImage,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 1,
              fit: BoxFit.fill,
            ),
            Center(
              child: Text(
                widget.product.productName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                '${widget.product.productPrice}₽',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Описание:\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.product.productAbout,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Характеристики:\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.product.productSpecifications,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(500, 237, 231, 246),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Row(
            children: [
              Container(
                child: badges.Badge(
                  badgeContent: Text(
                    "${widget.product.quantity}",
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.greenAccent,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      cartManager.addToCart(widget.product);
                    },
                    child: const Text("В корзину"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
                      backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Купить"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
                    backgroundColor: MaterialStateProperty.all(Colors.black12),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}