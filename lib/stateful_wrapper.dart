import 'package:flutter/material.dart';

class StatefulWrapper extends StatefulWidget {
  final Function? onInit;
  final Widget child;
  const StatefulWrapper({super.key, required this.onInit, required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit!();
      print('-------- its happening -------');
      print('-------- its happening -------');
      print('-------- its happening -------');
      print('-------- its happening -------');
      print('-------- its happening -------');
      print('-------- its happening -------');
    }
    print('-------- its happening but over here-------');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
