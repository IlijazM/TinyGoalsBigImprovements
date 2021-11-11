import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/core/internationalization_util.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_drawer.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/list/category_view.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/list/goal_view.dart';

Drawer getGlobalDrawer(BuildContext context) => CustomDrawer(
      title: l10n(context).core_app_name,
      items: [
        DrawerItem(
          title: l10n(context).entity_category,
          icon: const Icon(Icons.category),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoryView(),
            ),
          ),
        ),
        DrawerItem(
          title: l10n(context).entity_goal,
          icon: const Icon(Icons.flag),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GoalView(),
            ),
          ),
        ),
        const Divider(),
        DrawerItem(
          title: l10n(context).entity_goal_upcoming,
          icon: const Icon(Icons.new_releases),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GoalView(),
            ),
          ),
        ),
      ],
    );
