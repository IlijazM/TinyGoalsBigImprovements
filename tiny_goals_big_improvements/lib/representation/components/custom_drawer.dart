import 'package:flutter/material.dart';

class CustomDrawer extends Drawer {
  String title;
  List<Widget> items;
  String? backgroundImageUrl;

  CustomDrawer(
      {required this.title, required this.items, this.backgroundImageUrl})
      : super();

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [_createHeader(context, title), ...items],
        ),
      );
}

class DrawerItem extends ListTile {
  DrawerItem({
    required Icon icon,
    required String title,
    required GestureTapCallback onTap,
  }) : super(
          title: Row(
            children: <Widget>[
              icon,
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title),
              )
            ],
          ),
          onTap: onTap,
        );
}

Widget _createHeader(BuildContext context, String title) => DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: const DecorationImage(
          image: AssetImage("assets/abstract_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
