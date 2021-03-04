import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'bloc/text_bloc.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String txt;
  final TextBloc textBloc = TextBloc();
  TextEditingController _controller;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: '');
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: textBloc.text2Stream,
      builder: (ctx, shot){
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    minLines: 1,
                    maxLines: 5,
                    controller: _controller,
                    onChanged: (value){
                      if(value.length < 10){
                        txt = value;
                      }
                      //showing the text in text-field
                      _controller.value = _controller.value.copyWith(
                        text: txt,
                      );
                      textBloc.textSink.add(txt);
                      //setting cursor position
                      setState(() {
                        _counter = txt.length;
                        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
                      });
                    },
                  ),
                ),
                StreamBuilder(
                  stream: textBloc.textStream,
                  builder: (context, snapshot){
                    //to display the data in console
                    return FlatButton(
                      child: Text("Press to show the data"),
                      color: Colors.blueAccent,
                      onPressed: (){
                        if(snapshot.hasData && snapshot.data != ""){
                          print(snapshot.data);
                        }
                      },
                    );
                  },
                ),
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
