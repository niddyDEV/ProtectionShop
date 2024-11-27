import 'package:flutter/material.dart';
import 'package:prk3_3_3/components/item.dart';
import 'package:prk3_3_3/models/prod.dart';
import 'package:prk3_3_3/pages/add_product_page.dart';
import 'package:prk3_3_3/pages/product_page.dart'; // Импорт страницы товара

final List<Item> items = <Item>[
  Item(itemId: 1,
      itemTitle: "Venum Elite Helmet Khaki",
      imageItem: "assets/images/venum-kask-bokserski-elite-khaki-1-1000x1000.jpg",
      itemName: "Venum Elite Helmet Khaki",
      itemPrice: 10500,
      itemInfo: "Чтобы обеспечить защиту высочайшего качества, головной убор Elite изготовлен из полукожи, чтобы обеспечить комфорт во время ожидаемых интенсивных ударов по голове во время тренировки после тренировки.Головной убор Elite, хорошо известный своей прочностью, оснащен пеной тройной плотности для лучшего контроля ударов и амортизации."
  ),
  Item(itemId: 2,
    itemTitle: "Venum Elite Helmet Black Camouflage",
    imageItem: "assets/images/venum-kask-bokserski-elite-czarnydark-camo-1-1000x1000.jpg",
    itemName: "Venum Elite Helmet Black Camouflage",
    itemPrice: 9500,
    itemInfo: "Изготовлен из скинтекс - синтетической кожи высочайшего качества. Пена тройной плотности для поглощения ударов. Вертикальные и горизонтальные липучки обеспечивают идеальную посадку",
  ),
  Item(itemId: 3,
    itemTitle: "Venum Elite Helmet White'n'Black",
    imageItem: "assets/images/venum-kask-bokserski-elite-bialycamo-1-1000x1000.jpg",
    itemName: "Venum Elite Helmet White'n'Black",
    itemPrice: 8500,
    itemInfo: "Усиленный чехол для ушей. Дизайн с открытым верхом и сеткой для лучшего отвода пота и влаги. Гибкая двусторонняя застежка на липучке для индивидуальной нескользящей посадки. Ручная работа в Таиланде.",
  ),
  Item(itemId : 4,
    itemTitle: "Shingards VENUM Elite KHAKI/BLACK",
    imageItem:"assets/images/pr_23174_1.jpg",
    itemName:"Shingards VENUM Elite Khaki/Black",
    itemPrice: 17770,
    itemInfo:"Шингарды (накладки на ноги) Venum Elite Khaki/Black. Надежно защищают и голень, и стопу. А легендарными они стали из-за высокого коэффициента поглощения, лёгкости и удобной посадки. Шингарды предназначены для сильной работы ногами, поэтому они пользуются популярностью у бойцов тайского бокса и K-1.",
  ),
  Item(itemId : 5,
    itemTitle: "Shingards VENUM Elite BLACK/WHITE",
    imageItem:"assets/images/pr_23172_1.jpg",
    itemName:"Shingards VENUM Elite BLACK/WHITE",
    itemPrice: 17770,
    itemInfo:"Шингарды (накладки на ноги) Venum Elite Khaki/Black. Надежно защищают и голень, и стопу. А легендарными они стали из-за высокого коэффициента поглощения, лёгкости и удобной посадки. Шингарды предназначены для сильной работы ногами, поэтому они пользуются популярностью у бойцов тайского бокса и K-1.",
  ),
  Item(itemId : 5,
    itemTitle: "Shingards VENUM Elite BLACK/GOLD",
    imageItem:"assets/images/pr_23173_1.jpg",
    itemName:"Shingards VENUM Elite BLACK/GOLD",
    itemPrice: 17770,
    itemInfo:"Шингарды (накладки на ноги) Venum Elite Khaki/Black. Надежно защищают и голень, и стопу. А легендарными они стали из-за высокого коэффициента поглощения, лёгкости и удобной посадки. Шингарды предназначены для сильной работы ногами, поэтому они пользуются популярностью у бойцов тайского бокса и K-1.",
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _addProduct(Item item) {
    setState(() {
      items.add(item);
    });
  }

  void _deleteProduct(Item item) {
    setState(() {
      items.remove(item);
    });
  }

  void _toggleCart(Item item) {
    setState(() {
      item.isInCart = !item.isInCart;
    });
  }

  void _quantityChange(Item item, int newQuantity) {
    setState(() {
      item.quantity = newQuantity;
    });
  }

  void _toggleFavourite(Item item) {
    setState(() {
      item.isFavourite = !item.isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Protection Store",
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
          crossAxisCount: 2,
          childAspectRatio: 0.5,
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemItem(
            item: items[index],
            onDelete: _deleteProduct,
            onToggleCart: _toggleCart,
            onQuantityChange: _quantityChange,
            onToggleFavourite: _toggleFavourite,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(onAddProduct: _addProduct),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}