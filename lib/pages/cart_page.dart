import 'package:flutter/material.dart';
import 'package:prk3_3_3/components/cart_product.dart';
import 'package:prk3_3_3/models/cart_manager.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {

  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "КОРЗИНА",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 6,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return CartProduct(product: cartManager.cartProducts[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: cartManager.cartProducts.length,
      ),
    );
  }
}