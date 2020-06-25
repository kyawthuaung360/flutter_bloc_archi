import 'dart:convert';

import 'package:flutterblocarchi/models/post.dart';
import 'package:flutterblocarchi/networks/base_network.dart';
import 'package:flutterblocarchi/networks/enum/MsgState.dart';
import 'package:flutterblocarchi/networks/ob/responseob.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseNetwork{
  final endUrl = "https://jsonplaceholder.typicode.com/posts";


  PublishSubject<ResponseOb> controller = PublishSubject();
  Observable<ResponseOb> homepagestream() => controller.stream;

  getPose(){
    ResponseOb responseOb = ResponseOb(data: null,message: MsgState.loading);
    controller.sink.add(responseOb);


    getRequest(endUrl).then((rv){
      if (rv.message == MsgState.data) {
        var postlist = List<Post>();
        var parsed = json.decode(rv.data) as List<dynamic>;
        for(var post in parsed) {
          postlist.add(Post.fromJson(post));
        }
        responseOb.message = MsgState.data;
        responseOb.data = postlist;
        controller.sink.add(responseOb);
      }
    }).catchError((e) {
      responseOb.message = MsgState.error;
      responseOb.data = e.toString();
      controller.sink.add(responseOb);
    });
  }



  dispose(){
    controller.close();
  }

}