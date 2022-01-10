import 'package:flutter/material.dart';

class ThirdDatail extends StatelessWidget {
  const ThirdDatail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Container(
        child: Center(
            child: Text(
          args,
          style: TextStyle(fontSize: 30),
        )),
      ),
    );
  }
}
