import 'package:flutter/material.dart';
import 'package:prk3_3_3/components/b_nav_bar.dart';
import 'package:prk3_3_3/models/cart_manager.dart';
import 'package:prk3_3_3/models/favorite_manager.dart';
import 'package:prk3_3_3/models/cart_manager.dart';
import 'package:prk3_3_3/models/product_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteManager()),
        ChangeNotifierProvider(create: (_) => CartManager()),
        ChangeNotifierProvider(create: (_) => ProductManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const BNavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}