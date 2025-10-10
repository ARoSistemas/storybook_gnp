import 'dart:convert';

class Products {
  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.isFavorite,
  });

  // factory Products.fromRaw(String strRaw) =>
  //     Products.fromMap(json.decode(strRaw));

  factory Products.fromMap(Map<String, dynamic> json) => Products(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    price: (json['price'] as double?) ?? 0.0,
    description: json['description'] ?? '',
    category: json['category'] ?? '',
    image: json['image'] ?? '',
    rating: Rating.fromMap(json['rating']),
    isFavorite: false,
  );

  factory Products.empty() => Products(
    id: 0,
    title: '',
    price: 0,
    description: '',
    category: '',
    image: '',
    rating: Rating(rate: 0, count: 0),
    isFavorite: false,
  );
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;
  bool isFavorite;

  // List<Products> fromRaw(String str) =>
  //     List<Products>.from(jsonDecode(str).map((x) => Products.fromMap(x)));

  List<Products> fromRaw(String str) => List<Products>.from(
    (jsonDecode(str) as List<Products>).map(
      (x) => Products.fromMap(x as Map<String, dynamic>),
    ),
  );

  Products copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
    bool? isFavorite,
  }) => Products(
    id: id ?? this.id,
    title: title ?? this.title,
    price: price ?? this.price,
    description: description ?? this.description,
    category: category ?? this.category,
    image: image ?? this.image,
    rating: rating ?? this.rating,
    isFavorite: isFavorite ?? this.isFavorite,
  );
}

class Rating {
  Rating({required this.rate, required this.count});

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
    rate: (json['rate'] as double?) ?? 0.0,
    count: (json['count'] as int?) ?? 0,
  );

  double rate;
  int count;

  Rating copyWith({double? rate, int? count}) =>
      Rating(rate: rate ?? this.rate, count: count ?? this.count);
}
