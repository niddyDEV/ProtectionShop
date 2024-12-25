import 'package:flutter/material.dart';
import 'package:prk3_3_3/models/product.dart';
import 'package:prk3_3_3/pages/fav_page.dart';
import 'package:prk3_3_3/pages/home_page.dart';
import 'package:prk3_3_3/pages/profile.dart';
import 'package:prk3_3_3/pages/cart_page.dart';
import 'package:prk3_3_3/models/cart_manager.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class BNavBar extends StatefulWidget {
  const BNavBar({super.key});

  @override
  State<BNavBar> createState() => _BNavBarState();
}

class _BNavBarState extends State<BNavBar> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavPage(),
    ShoppingCart(),
    Profile(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);
    return Scaffold(
      body:
      _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Главная",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Избранное",
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
                badgeContent: Text(
                  "${cartManager.cartProducts.length}",
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.greenAccent,
                ),
                child: const Icon(Icons.shopping_cart_outlined)
            ),
            label: "Корзина",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Личный кабинет",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}