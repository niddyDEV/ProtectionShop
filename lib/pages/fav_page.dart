import 'package:flutter/material.dart';
import 'package:prk3_3_3/models/favorite_manager.dart';
import 'package:provider/provider.dart';
import 'package:prk3_3_3/components/product_item.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "ИЗБРАННОЕ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 6,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // количество элементов в сетке
          crossAxisSpacing: 2.0, // расстояние между столбцами
          mainAxisSpacing: 2.0, // расстояние между строками
          childAspectRatio: 0.76, // соотношение сторон элементов
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductItem(product: favoriteManager.favProducts[index], index: index,);
        },
        itemCount: favoriteManager.favProducts.length,
      ),
    );
  }
}





