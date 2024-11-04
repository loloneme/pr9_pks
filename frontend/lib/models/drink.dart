import 'dart:ffi';
import 'package:flutter/material.dart';


class Drink{
  final int id;
  final String image;
  final String name;
  final String description;
  final List<String> compound;
  final bool cold;
  final bool hot;
  final Map<String, int> prices;
  bool isFavorite;

  Drink({required this.id, required this.image, required this.name,
    required this.description, required this.compound,
    required this.cold, required this.hot, required  this.prices, required this.isFavorite});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      id: json['drink_id'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      compound:  List<String>.from(json['compound']),
      cold: json['is_cold'],
      hot: json['is_hot'],
      prices: Map<String, int>.from(json['prices']),
      isFavorite: json['is_favorite']
    );
  }
}