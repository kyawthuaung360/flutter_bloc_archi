

import 'dart:convert';

import 'package:flutterblocarchi/models/post.dart';
import 'package:flutterblocarchi/networks/base_network.dart';
import 'package:flutterblocarchi/networks/enum/MsgState.dart';
import 'package:flutterblocarchi/networks/ob/responseob.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseNetwork{
  String endUrl = 'https://jsonplaceholder.typicode.com/posts';

  PublishSubject<ResponseOb> _loginController = PublishSubject<ResponseOb>();
  Observable<ResponseOb> loginStream() => _loginController.stream;

  login(String id){
    ResponseOb reob = ResponseOb(message: MsgState.loading,data: null);
    _loginController.sink.add(reob);
    int cusid = int.tryParse(id);
    if(cusid > 10 || cusid<1 ){
      reob.message = MsgState.error;
      reob.data = 'input error';
      _loginController.sink.add(reob);
    }else {
      getRequest(endUrl+"/$cusid").then((rv) {
        Map<String, dynamic> map = json.decode(rv.data);
        if (rv.data != null) {
          Post p = Post.fromJson(map);
          reob.message = MsgState.data;
          reob.data = p;
          _loginController.sink.add(reob);
        } else {
          reob.message = MsgState.error;
          reob.data = "error";
          _loginController.sink.add(reob);
        }
      }).catchError((e) {
        reob.message = MsgState.error;
        reob.data = e.toString();
        _loginController.sink.add(reob);
      });
    }
  }


  dispose(){
    _loginController.close();
  }

}