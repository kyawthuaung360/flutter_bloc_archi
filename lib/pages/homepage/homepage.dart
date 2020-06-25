

import 'package:flutter/material.dart';
import 'package:flutterblocarchi/models/post.dart';
import 'package:flutterblocarchi/networks/enum/MsgState.dart';
import 'package:flutterblocarchi/networks/ob/responseob.dart';
import 'package:flutterblocarchi/pages/homepage/bloc/home_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  Post post;
  HomePage({this.post});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    _homeBloc.getPose();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }


  @override
  void initState() {
    // TODO: implement initState
    _homeBloc = HomeBloc();
    _homeBloc.getPose();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Text('${widget.post.title}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          StreamBuilder(
            stream: _homeBloc.homepagestream(),
            initialData: ResponseOb(data: null,message: MsgState.loading),
            builder: (context,snapshot){
              ResponseOb res = snapshot.data;
              List<Post> listpos = res.data;
              if(res.message == MsgState.loading){
                return Center(child: CircularProgressIndicator(),);
              }else if(res.message == MsgState.data){
                return Expanded(
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: listpos.length,
                        itemBuilder: (context,i){
                      return eachItemCard(listpos[i]);
                    }),
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );


  }

  Widget eachItemCard(Post p){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: 100,
          child: Card(
            color: Colors.green,
            elevation: 2,
            child:  Text('${p.title}'),
          ),
        ),
        onTap: ()=> Navigator.pushNamed(context, '/detail',arguments: p),
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _homeBloc.dispose();
    super.dispose();
  }
}
