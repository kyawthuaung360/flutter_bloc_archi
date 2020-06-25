import 'package:flutter/material.dart';
import 'package:flutterblocarchi/models/post.dart';
import 'package:flutterblocarchi/networks/enum/MsgState.dart';
import 'package:flutterblocarchi/pages/counterbloc/counter_bloc.dart';

class DetailPage extends StatelessWidget {
  Post p;
  DetailPage(this.p);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail page'),),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${p.title}'),
            Text('${p.userId}'),
            Text('${p.body}'),
            Text('${p.id}'),
            CounterWidget(),
          ],
        ),
      ),
    );
  }
}



class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  CounterBloc counterBloc;



  int i=0;

  @override
  void initState() {
    // TODO: implement initState
    counterBloc = CounterBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.minimize),
          onPressed: (){
            counterBloc.counterEventSink.add(CounterState.decrement);
          },
        ),
        StreamBuilder(
          stream: counterBloc.counter,
          initialData: 0,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Counter Value:',
                ),
                Text(
                  '${snapshot.data}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1,
                ),
              ],
            );
          }
    ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            counterBloc.counterEventSink.add(CounterState.increment);
          },
        )
      ],
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    counterBloc.dispose();
    super.dispose();
  }
}

