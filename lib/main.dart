import 'package:flutter/material.dart';
import 'package:my_flutter/injection_container.dart';
import 'package:my_flutter/ui/search/search_page.dart';

void main() {
  initKiwi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red.shade600,
        accentColor: Colors.red.shade400,
      ),
      home: SearchPage(),
    );
  }
}
