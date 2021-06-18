import 'package:brand_name2/routes/routes.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brand Names',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: routes,
    );
  }
}