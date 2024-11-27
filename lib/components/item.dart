import 'package:flutter/material.dart';
import 'package:prk3_3_3/models/prod.dart';
import 'package:prk3_3_3/pages/product_page.dart';

class ItemItem extends StatelessWidget {
  final Item item;
  final Function(Item) onDelete;
  final Function(Item) onToggleCart;
  final Function(Item, int) onQuantityChange;
  final Function(Item) onToggleFavourite;

  const ItemItem({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onToggleCart,
    required this.onQuantityChange,
    required this.onToggleFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemPage(
              item: item,
              onDelete: onDelete, // Передаем функцию удаления
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(234, 213, 208, 208),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  item.itemName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Выравнивание текста по центру
                ),
              ),
              Image.asset(
                item.imageItem,
                height: 100, // Уменьшим высоту изображения
                width: 100, // Уменьшим ширину изображения
                fit: BoxFit.cover,
              ),
              Center(
                child: Text(
                  '${item.itemPrice}₽',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          onToggleCart(item);
                        },
                        child: Text(item.isInCart ? "Убрать из корзины" : "В корзину"),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 16)), // Уменьшенный размер кнопки
                          backgroundColor: MaterialStateProperty.all(
                              Colors.grey),
                          foregroundColor: MaterialStateProperty.all(
                              Colors.black),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // Промежуток между кнопками
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Купить"),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 16)), // Уменьшенный размер кнопки
                          backgroundColor: MaterialStateProperty.all(
                              Colors.amberAccent),
                          foregroundColor: MaterialStateProperty.all(
                              Colors.black),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // Промежуток между кнопками и иконками
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Перемещение иконок вправо
                        children: [
                          IconButton(
                            icon: Icon(
                              item.isFavourite ? Icons.favorite : Icons.favorite_border,
                              color: item.isFavourite ? Colors.red : null,
                            ),
                            onPressed: () {
                              onToggleFavourite(item);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Удалить товар?'),
                                    content: const Text(
                                        'Вы уверены, что хотите удалить этот товар?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Отмена'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          onDelete(item);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Удалить'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          if (item.isInCart)
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    onQuantityChange(item, item.quantity - 1);
                                  },
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    onQuantityChange(item, item.quantity + 1);
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
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