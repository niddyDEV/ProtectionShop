import 'package:flutter/material.dart';
import 'package:prk3_3_3/models/prod.dart';

class ItemPage extends StatefulWidget {
  final Item item;
  final Function(Item) onDelete; // Добавляем функцию для удаления товара

  const ItemPage({super.key, required this.item, required this.onDelete});

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(234, 213, 208, 208),
      appBar: AppBar(
        title: Text(widget.item.itemTitle),
        actions: [
          IconButton(
            icon: Icon(
              widget.item.isFavourite ? Icons.favorite : Icons.favorite_border,
              color: widget.item.isFavourite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                widget.item.isFavourite = !widget.item.isFavourite;
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              widget.item.itemName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Image.asset(
            widget.item.imageItem,
            height: 200, // Уменьшим высоту изображения
            width: 200, // Уменьшим ширину изображения
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              '${widget.item.itemPrice}₽',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              widget.item.itemInfo, style: TextStyle(fontSize: 24),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.item.isInCart = !widget.item.isInCart;
                        });
                      },
                      child: Text(widget.item.isInCart ? "Убрать из корзины" : "В корзину"),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16,),
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
                        backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.item.isInCart)
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (widget.item.quantity > 1) {
                                widget.item.quantity--;
                              }
                            });
                          },
                        ),
                        Text('${widget.item.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              widget.item.quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          // Добавляем кнопку удаления товара
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
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
                              widget.onDelete(widget.item);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop(); // Возвращаемся на предыдущую страницу
                            },
                            child: const Text('Удалить'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Удалить товар'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}