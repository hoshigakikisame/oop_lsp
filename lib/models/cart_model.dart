// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  Cart({
    required this.id,
    required this.createdAt,
    this.customerName,
    required this.grandTotal,
    required this.changes,
    required this.isActive,
  });

  int id;
  DateTime createdAt;
  String? customerName;
  int grandTotal;
  int changes;
  bool isActive;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        customerName: json["customer_name"] ?? '',
        grandTotal: json["grand_total"],
        changes: json["changes"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "customer_name": customerName,
        "grand_total": grandTotal,
        "changes": changes,
        "is_active": isActive,
      };
}
