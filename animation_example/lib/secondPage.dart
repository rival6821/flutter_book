import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPage createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation Example2')),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Hero(
                tag: 'detail',
                child: Icon(
                  Icons.cake,
                  size: 150,
                )),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )),
      ),
    );
  }
}
