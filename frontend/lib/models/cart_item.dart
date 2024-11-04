import 'dart:ffi';
import 'package:flutter/material.dart';


class CartItem{
  final int drink_id;
  final String name;
  final String image;
  bool isCold;
  int amount;
  int priceOfOneItem;
  String volume;

  CartItem(this.drink_id, this.name, this.image, this.isCold, this.amount, this.priceOfOneItem, this.volume);
}