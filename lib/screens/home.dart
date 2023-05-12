import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    required this.data,
  });
  final Object? data;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map args = {};
  List _todos = <Map>[];

  @override
  void initState() {
    super.initState();
    print('yes it works');
    if (widget.data != null) {
      _todos.add({'uuid': 'spmthing', 'text': 'yes sure'});
    }
  }

  void _incrementCounter() {
    Navigator.pushNamed(context, '/add');
    // setState(() {
    //   _todos.add(_number++);
    //   print('_todos $_todos');
    // });
  }

  void handleTap() {
    print('Yeah you are tapping shit outa it');
  }

  void handleLongPress() {
    print('You are pressing it tooo hard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          // mainAxisAlignment: MainAxisAlignment.center,
          child: (ListView(
            children: <Widget>[
              Column(
                  children: _todos != null
                      ? _todos
                          .map<Widget>((item) => Card(
                              child: InkWell(
                                  onTap: handleTap,
                                  onLongPress: handleLongPress,
                                  child: Container(
                                    margin: EdgeInsets.all(20.0),
                                    child: new Text(item),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 50,
                                  ))))
                          .toList()
                      : [])
              // : const Text('Empty'),
            ],
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        // tooltip: 'Increment',
        label: Text("Add Habit"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
