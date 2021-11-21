import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/main.dart';
import 'package:tiny_goals_big_improvements/repository/options_repository.dart';
import 'package:tiny_goals_big_improvements/representation/components/restart_widget.dart';
import 'package:tiny_goals_big_improvements/representation/views/layout/global.dart';

AppBar getGlobalAppBar(
        {required BuildContext context,
        required String title,
        Color? backgroundColor,
        Color? foregroundColor}) =>
    AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      actions: [
        IconButton(
          icon: const Icon(Icons.translate),
          onPressed: () => showPopupMenu(context),
        ),
        const SizedBox(
          width: 12,
        ),
      ],
    );

showPopupMenu(BuildContext context) {
  showMenu<String>(
    context: context,
    position: const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
    items: const [
      PopupMenuItem<String>(child: Text('en'), value: 'en'),
      PopupMenuItem<String>(child: Text('de'), value: 'de'),
    ],
    elevation: 8.0,
  ).then<void>((itemSelected) {
    locale = itemSelected ?? 'en';
    OptionsRepository().saveLanguage(itemSelected ?? 'en');
    RestartWidget.restartApp(context);
  });
}
