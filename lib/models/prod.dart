class Item {
  final int itemId;
  final String itemTitle;
  final String imageItem;
  final String itemName;
  final int itemPrice;
  final String itemInfo;
  bool isFavourite;
  bool isInCart;
  int quantity;

  Item({
    required this.itemId,
    required this.itemTitle,
    required this.imageItem,
    required this.itemName,
    required this.itemPrice,
    required this.itemInfo,
    this.isFavourite = false,
    this.isInCart = false,
    this.quantity = 1,
  });
}