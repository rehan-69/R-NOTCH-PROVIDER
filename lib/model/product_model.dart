import 'rating_model.dart';

class Product {
  final int id;
  final String title;
  num price;
  final String image;
  final String description;
  final String category;
  final Rating rating;
  String buttonName;
  bool favourite;
  String selectedSize;
  String size;
  int selectQtyIndex;
  int qtySelect;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    required this.rating,
    this.buttonName = 'Add to Cart',
    this.favourite = false,
    this.selectedSize = 'XS',
    this.size = 'XS',
    this.selectQtyIndex = 0,
    this.qtySelect = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'description': description,
      'category': category,
      'rating': rating.toMap(),
      'buttonName': buttonName,
      'favourite': favourite,
      'selectedSize': selectedSize,
      'selectQtyIndex': selectQtyIndex,
      'size': size,
      'qtySelect': qtySelect,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,

      title: map['title'] ?? '',

      price: (map['price'] ?? 0).toDouble(),

      image: map['image'] ?? '',

      description: map['description'] ?? '',

      category: map['category'] ?? '',

      rating: Rating.fromMap(map['rating'] ?? {}),
      
      buttonName: map['buttonName'] ?? 'Add to Cart',

      favourite: map['favourite'] ?? false,

      selectedSize: map['selectedSize'] ?? 'XS',

      size: map['size'] ?? 'XS',

      selectQtyIndex: map['selectQtyIndex'] ?? 0,

      qtySelect: map['qtySelect'] ?? 1,
    );
  }
}
