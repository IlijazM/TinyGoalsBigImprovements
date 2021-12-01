import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiny_goals_big_improvements/core/logger_util.dart';
import 'package:tiny_goals_big_improvements/repository/options_repository.dart';
import 'package:tiny_goals_big_improvements/representation/components/restart_widget.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/list/category_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tiny_goals_big_improvements/representation/views/layout/global.dart';
import 'package:tiny_goals_big_improvements/service/notification_service.dart';

Future<void> main() async {
  initLogger();

  // Need this because of touch issues. See: https://github.com/flutter/flutter/issues/76325
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.instance.scheduleNotification();

  runApp(RestartWidget(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (locale == null) {
      OptionsRepository().getLanguage().then((res) {
        locale = res ?? 'en';
        RestartWidget.restartApp(context);
      });
    }

    return MaterialApp(
      locale: Locale(locale ?? 'en'),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      home: CategoryView(),
    );
  }
}
