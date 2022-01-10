import 'package:flutter/material.dart';

class SecondDatail extends StatelessWidget {
  const SecondDatail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('SecondPage'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(controller.value.text);
                  },
                  child: Text('저장하기'))
            ],
          ),
        ),
      ),
    );
  }
}
