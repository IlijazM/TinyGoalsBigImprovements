import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/core/internationalization_util.dart';

Drawer getGlobalDrawer(BuildContext context) => Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          // DrawerHeader(
          //   decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          //   child: const Text('Drawer Header'),
          // ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.category),
                const Text('    '),
                Text(l10n(context).entity_category)
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.flag),
                const Text('    '),
                Text(l10n(context).entity_goal),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
