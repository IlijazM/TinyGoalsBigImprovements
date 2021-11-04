import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameIconDataTupel {
  final String name;
  final IconData iconData;

  NameIconDataTupel({required this.name, required this.iconData});
}

final List<NameIconDataTupel> categoryIcons = [
  NameIconDataTupel(iconData: Icons.sports_basketball_sharp, name: 'Sports'),
  NameIconDataTupel(iconData: Icons.restaurant, name: 'Food'),
  NameIconDataTupel(iconData: Icons.menu_book, name: 'Reading'),
  NameIconDataTupel(iconData: Icons.school, name: 'Education'),
  NameIconDataTupel(iconData: Icons.square_foot, name: 'Math'),
  NameIconDataTupel(iconData: Icons.science, name: 'Sience'),
  NameIconDataTupel(iconData: Icons.home, name: 'Home'),
  NameIconDataTupel(iconData: Icons.code, name: 'Coding'),
];
