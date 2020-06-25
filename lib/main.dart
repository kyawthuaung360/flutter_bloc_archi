import 'package:flutter/material.dart';
import 'package:flutterblocarchi/pages/loginpage/login_page.dart';
import 'package:flutterblocarchi/ui/share/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      onGenerateRoute: Router.generateRoute,
    );
  }
}

