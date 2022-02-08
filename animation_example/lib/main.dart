import 'package:animation_example/intro.dart';
import 'package:animation_example/people.dart';
import 'package:animation_example/secondPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPage(),
    );
  }
}

class AnimationApp extends StatefulWidget {
  @override
  State<AnimationApp> createState() => _AnimationApp();
}

class _AnimationApp extends State<AnimationApp> {
  List<People> peoples = List.empty(growable: true);
  Color weightColor = Colors.blue;
  int current = 0;
  double _opacity = 1;

  @override
  void initState() {
    peoples.add(People('스미스', 180, 92));
    peoples.add(People('김씨', 173, 54));
    peoples.add(People('박씨', 187, 99));
    peoples.add(People('최씨', 165, 47));
    peoples.add(People('이씨', 170, 62));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation Example'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(seconds: 1),
                  child: SizedBox(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text('이름 : ${peoples[current].name}'),
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 2),
                          curve: Curves.bounceIn,
                          color: Colors.amber,
                          child: Text(
                            '키 ${peoples[current].height}',
                            textAlign: TextAlign.center,
                          ),
                          width: 50,
                          height: peoples[current].height,
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 2),
                          curve: Curves.easeInCubic,
                          color: weightColor,
                          child: Text(
                            '몸무게 ${peoples[current].weight}',
                            textAlign: TextAlign.center,
                          ),
                          width: 50,
                          height: peoples[current].weight,
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 2),
                          curve: Curves.linear,
                          color: Colors.pinkAccent,
                          child: Text(
                            'bmi ${peoples[current].bmi.toString().substring(0, 2)}',
                            textAlign: TextAlign.center,
                          ),
                          width: 50,
                          height: peoples[current].bmi,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                    height: 200,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (current < peoples.length - 1) {
                          current++;
                        }
                        _changeWeightColor(peoples[current].weight);
                      });
                    },
                    child: Text('다음')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (current > 0) {
                          current--;
                        }
                        _changeWeightColor(peoples[current].weight);
                      });
                    },
                    child: Text('이전')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _opacity = _opacity == 1 ? 0 : 1;
                      });
                    },
                    child: Text('사라지기')),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SecondPage()));
                  },
                  child: SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        Hero(tag: 'detail', child: Icon(Icons.cake)),
                        Text('이동하기')
                      ],
                    ),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ));
  }

  void _changeWeightColor(double weight) {
    if (weight < 40) {
      weightColor = Colors.blueAccent;
    } else if (weight < 60) {
      weightColor = Colors.indigo;
    } else if (weight < 80) {
      weightColor = Colors.orange;
    } else {
      weightColor = Colors.red;
    }
  }
}
