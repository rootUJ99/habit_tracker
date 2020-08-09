import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    @required this.data,
  });
  final List data;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map args = {};
  List _todos = [];
  List data1 = <String>[
    'ichi',
    'ni',
    'san',
    'shi',
    'go',
    'roku',
    'shichi',
    'hachi',
    'ku',
    'ju',
  ];
  void _incrementCounter() {
    Navigator.pushNamed(context, '/add');
    // setState(() {
    //   _todos.add(_number++);
    //   print('_todos $_todos');
    // });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   print("yo => ${args['todos']}");
  //   setState(() {
  //     _todos.add(args['todos']);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print("yo => ${data}");
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          // mainAxisAlignment: MainAxisAlignment.center,
          child: (ListView(
            children: <Widget>[
              // args['todos'] != null?
              Column(
                  children: data1
                      .map<Widget>((item) => Card(
                              child: Container(
                            margin: EdgeInsets.all(20.0),
                            child: new Text(item),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 50,
                          )))
                      .toList())
              // : const Text('Empty'),
            ],
          )),
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
