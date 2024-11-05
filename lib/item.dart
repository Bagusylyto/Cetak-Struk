// item.dart
import 'package:flutter/material.dart';

class Item {
  final String name;
  final int price;
  final TextEditingController controller;

  Item({required this.name, required this.price, required this.controller});
}
