import 'package:flutter/material.dart';
import 'package:prk3_3_3/models/prod.dart';

class AddProductPage extends StatefulWidget {
  final Function(Item) onAddProduct;

  const AddProductPage({super.key, required this.onAddProduct});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String _itemTitle;
  late String _imageItem;
  late String _itemName;
  late int _itemPrice;
  late String _itemInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить товар'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите название';
                  }
                  return null;
                },
                onSaved: (value) => _itemTitle = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ссылка на изображение'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите ссылку на изображение';
                  }
                  return null;
                },
                onSaved: (value) => _imageItem = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Имя товара'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите имя товара';
                  }
                  return null;
                },
                onSaved: (value) => _itemName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите цену';
                  }
                  return null;
                },
                onSaved: (value) => _itemPrice = int.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Информация о товаре'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите информацию о товаре';
                  }
                  return null;
                },
                onSaved: (value) => _itemInfo = value!,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newItem = Item(
                      itemId: DateTime.now().millisecondsSinceEpoch,
                      itemTitle: _itemTitle,
                      imageItem: _imageItem,
                      itemName: _itemName,
                      itemPrice: _itemPrice,
                      itemInfo: _itemInfo,
                    );
                    widget.onAddProduct(newItem);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Добавить товар'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}