

import 'package:flutter/material.dart';
import 'package:flutterblocarchi/models/post.dart';
import 'package:flutterblocarchi/pages/detailpage/detail_page.dart';
import 'package:flutterblocarchi/pages/homepage/homepage.dart';
import 'package:flutterblocarchi/pages/loginpage/login_page.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginPage());

      case "/home":
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => HomePage(post: post,));
      case "/detail":
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => DetailPage(post));
      default:
        return MaterialPageRoute(builder: (_) =>
        Scaffold(
          body: Center(child: Text("no route"),),
        ));
    }
  }
}