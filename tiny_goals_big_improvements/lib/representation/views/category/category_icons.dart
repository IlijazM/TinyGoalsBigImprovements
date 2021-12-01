import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/core/internationalization_util.dart';

class NameIconDataTupel {
  final String Function(BuildContext context) name;
  final IconData iconData;

  NameIconDataTupel({required this.name, required this.iconData});
}

final List<NameIconDataTupel> categoryIcons = [
  NameIconDataTupel(
      iconData: Icons.sports_basketball_sharp,
      name: (context) => l10n(context).icon_sport),
  NameIconDataTupel(
      iconData: Icons.restaurant, name: (context) => l10n(context).icon_food),
  NameIconDataTupel(
      iconData: Icons.menu_book, name: (context) => l10n(context).icon_book),
  NameIconDataTupel(
      iconData: Icons.school, name: (context) => l10n(context).icon_education),
  NameIconDataTupel(
      iconData: Icons.square_foot, name: (context) => l10n(context).icon_math),
  NameIconDataTupel(
      iconData: Icons.science, name: (context) => l10n(context).icon_science),
  NameIconDataTupel(
      iconData: Icons.home, name: (context) => l10n(context).icon_home),
  NameIconDataTupel(
      iconData: Icons.code, name: (context) => l10n(context).icon_coding),
  NameIconDataTupel(
      iconData: Icons.work, name: (context) => l10n(context).icon_work),
  NameIconDataTupel(
      iconData: Icons.translate,
      name: (context) => l10n(context).icon_translate),
  NameIconDataTupel(
      iconData: Icons.extension,
      name: (context) => l10n(context).icon_extension),
  NameIconDataTupel(
      iconData: Icons.person, name: (context) => l10n(context).icon_person),
  NameIconDataTupel(
      iconData: Icons.group, name: (context) => l10n(context).icon_group),
  NameIconDataTupel(
      iconData: Icons.groups, name: (context) => l10n(context).icon_groups),
  NameIconDataTupel(
      iconData: Icons.sports_esports,
      name: (context) => l10n(context).icon_sports_esports),
];
