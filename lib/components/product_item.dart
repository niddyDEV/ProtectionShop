import 'package:flutter/material.dart';
import 'package:prk3_3_3/api/api_service.dart';
import 'package:prk3_3_3/models/product.dart';
import 'package:prk3_3_3/models/product_manager.dart';
import 'package:prk3_3_3/pages/product_page.dart';
import 'package:prk3_3_3/models/favorite_manager.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final int index;

  const ProductItem({super.key, required this.product, required this.index});

  @override
  _ProductItemState createState() => _ProductItemState(product: product);
}
class _ProductItemState extends State<ProductItem> {
  final Product product;
  _ProductItemState({required this.product}) : super();

  late Future<List<Product>> _products;

  @override
  void initState(){
    super.initState();
    _products = ApiService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(product: widget.product,)),
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(45, 237, 231, 246),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        widget.product.productImage,
                        height: 180, // Уменьшенная высота изображения
                        width: 180, // Уменьшенная ширина изображения
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${widget.product.productPrice}₽',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(child: Text(
                    widget.product.productName,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    favoriteManager.isFavorite(product) ? Icons.favorite : Icons.favorite_border,
                    color: favoriteManager.isFavorite(product) ? Colors.red : Colors.grey,
                  ),
                  onPressed:(){
                    if (favoriteManager.isFavorite(product)){
                      favoriteManager.removeFromFavorite(product);
                    } else{
                      favoriteManager.addToFavorite(product);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}