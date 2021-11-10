import 'dart:convert';

class Product {
  Product({
    this.name,
    this.picture,
    this.price,
    this.id,
    this.count,
  });

  String name;
  String picture;
  double price;
  String id;
  int count = 0;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "picture": picture,
        "price": price,
        "id": id == null ? null : id,
      };
}
