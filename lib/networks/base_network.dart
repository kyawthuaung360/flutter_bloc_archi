import 'dart:io';

import 'package:flutterblocarchi/networks/enum/MsgState.dart';
import 'package:http/http.dart' as http;
import 'package:flutterblocarchi/networks/ob/responseob.dart';

class BaseNetwork {
  Future<Map<String, String>> getHeader() async {
//  String ss = await SharedPref.getData(key: SharedPref.langauge);
//  if (ss == null || ss == "null") {
//  ss = "en";
//  } else if (ss == "mm") {
//  ss = 'mm_zg';
//  } else if (ss == "uni") {
//  ss = 'mm_uni';
//  }
  return {
//  "Authorization": await SharedPref.getData(key: SharedPref.token),
  "Accept": "application/json",
//  "language": ss
  };
  }

  Future<ResponseOb> getRequest(String url) async{
    ResponseOb responseOb = ResponseOb();
    return  http.get(url).then((value)  {
      if(value.statusCode == 200){
        responseOb.message = MsgState.data;
        responseOb.data = value.body.toString();
      }else{
        responseOb.message = MsgState.error;
        responseOb.data = "Data Fetching Error!";
      }
      return responseOb;
    }).catchError((e){
      if(e is SocketException){
        responseOb.message = MsgState.error;
        responseOb.data = "No Internet";
      }else{
        responseOb.message = MsgState.error;
        responseOb.data = "Data ${e.toString()} Error";
      }
      return responseOb;
    });
  }


}