import 'package:flutter/material.dart';
import 'package:giphy_searcher/ui/main_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainInheritedWidget(Text('Hi!')),
    );
  }
}