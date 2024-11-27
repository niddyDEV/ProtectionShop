import 'package:flutter/material.dart';
import 'package:prk3_3_3/components/item.dart';
import 'package:prk3_3_3/models/prod.dart';
import 'package:prk3_3_3/pages/home_page.dart'; // Импорт списка товаров

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> favoriteItems = items.where((item) => item.isFavourite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favoriteItems.isEmpty
          ? const Center(
        child: Text('Нет избранных товаров'),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.5,
        ),
        itemCount: favoriteItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemItem(
            item: favoriteItems[index],
            onDelete: (item) {
              // Удаление товара из списка
              items.remove(item);
            },
            onToggleCart: (item) {
              // Переключение корзины
              item.isInCart = !item.isInCart;
            },
            onQuantityChange: (item, newQuantity) {
              // Изменение количества
              item.quantity = newQuantity;
            },
            onToggleFavourite: (item) {
              // Переключение избранного
              item.isFavourite = !item.isFavourite;
            },
          );
        },
      ),
    );
  }
}