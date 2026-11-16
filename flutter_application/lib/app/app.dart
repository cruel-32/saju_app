import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';

class BoriumApp extends StatelessWidget {
  const BoriumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '보리음',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: Routes.home,
      routes: buildRoutes(),
    );
  }
}
