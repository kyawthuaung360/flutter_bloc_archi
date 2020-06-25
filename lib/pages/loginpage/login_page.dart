import 'package:flutter/material.dart';
import 'package:flutterblocarchi/Utils/app_utils.dart';
import 'package:flutterblocarchi/models/post.dart';
import 'package:flutterblocarchi/networks/enum/MsgState.dart';
import 'package:flutterblocarchi/pages/loginpage/bloc/login_bloc.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc;
  bool isLogin = false;
  String loginresult;
  String loginError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loginBloc = LoginBloc();
    _loginBloc.loginStream().listen((res) {
      print('--->>> ${res.message}');
      if(res.message == MsgState.loading){
        setState(() {
          isLogin = true;
        });
      }else if(res.message == MsgState.data){
        Post p = res.data;
        setState(() {
          isLogin = false;
        });
        Navigator.pushNamed(context, '/home', arguments: p);
      }else if(res.message == MsgState.error){
        setState(() {
          isLogin = false;
          loginError = res.data;
        });
        AppUtils.showSnackBar('${res.data}', _scaffoldkey.currentState,color: Colors.red, textColor: Colors.white);
      }
    });
  }
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            TextField(
              controller: _controller,
              onChanged: (val){
                if(val.isNotEmpty){
                  setState(() {
                    loginError = "";
                  });
                }
              },
              decoration: InputDecoration(
                errorText: loginError,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,//this has no effect
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Border decoration text ...",
              ),
            ),
            isLogin == false ? RaisedButton(
              child: Text('Login'),
              onPressed: () => _loginBloc.login(_controller.text),
            ) : CircularProgressIndicator(),
          ],
        ),
      ),

    );
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _loginBloc.dispose();
    super.dispose();
  }
}
