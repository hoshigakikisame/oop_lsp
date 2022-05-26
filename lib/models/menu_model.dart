// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

List<Menu> menuProfileFromJson(String str) =>
    List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuProfileToJson(List<Menu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
  Menu(
      {this.id,
      this.createdAt,
      required this.name,
      required this.price,
      this.type,
      this.image,
      required this.description});

  int? id;
  DateTime? createdAt;
  String name;
  int price;
  int? type;
  String? image;
  String description;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
      id: json["id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ''),
      name: json["name"],
      price: json["price"],
      type: json["type"],
      image: json["image"],
      description: json['description']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "price": price,
        "type": type,
        "image": image,
        "description": description
      };
}
