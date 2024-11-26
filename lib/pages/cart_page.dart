import 'package:flutter/material.dart';
import 'package:prk3_3_3/models/prod.dart';
import 'package:prk3_3_3/pages/home_page.dart'; // Импорт списка товаров

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final List<Item> cartItems = items.where((item) => item.isInCart).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text('Корзина пуста'),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(cartItems[index].itemId.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                cartItems[index].isInCart = false;
                cartItems.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${cartItems[index].itemName} удален из корзины'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(cartItems[index].itemName),
              subtitle: Text('${cartItems[index].itemPrice}₽'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (cartItems[index].quantity > 1) {
                          cartItems[index].quantity--;
                        }
                      });
                    },
                  ),
                  Text('${cartItems[index].quantity}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        cartItems[index].quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}