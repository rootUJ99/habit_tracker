import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map args = {};
  List _todos = [];
  void _incrementCounter() {
    Navigator.pushNamed(context, '/add');
    // setState(() {
    //   _todos.add(_number++);
    //   print('_todos $_todos');
    // });
  }

  @override
  void initState() {
    super.initState();
    print("yo => ${args['todos']}");
    setState(() {
      _todos.add(args['todos']);
    });
  }

  @override
  Widget build(BuildContext context) {
    args = args.isNotEmpty ? args : ModalRoute.of(context).settings.arguments;
    print("yo => ${args['todos']}");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ListView(
            //   children: <Widget>[],
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
