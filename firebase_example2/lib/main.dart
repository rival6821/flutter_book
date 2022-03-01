import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example2/memoPage.dart';
import 'package:firebase_example2/tabsPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error'),);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            _initFirebaseMessaging(context);
            _getToken();
            return MemoPage();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
      // home: FirebaseApp(
      //   analytics: analytics,
      //   observer: observer
      // ),
    );
  }

  _initFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.title);
      print(event.notification!.body);
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('알림'),
          content: Text(event.notification!.body!),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Ok'))
          ],
        );
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) { });
  }

  _getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    print('messaging.getToken(), ${await messaging.getToken()}');
  }
}

class FirebaseApp extends StatefulWidget {
  FirebaseApp({key, required this.analytics, required this.observer}) :
        super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _FirebaseAppState createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp> {
  _FirebaseAppState(this.analytics, this.observer);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  String _message = '';

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(name: 'test_event', parameters: <String, dynamic>{
      'string' : 'hello flutter',
      'int' : 100,
    });
    setMessage('Analystics 보내기 성공');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: _sendAnalyticsEvent, child: Text('테스트')),
            Text(_message, style: const TextStyle(color: Colors.blueAccent),)
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.tab), onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
          return TabsPage(observer);
        }, settings: RouteSettings(name: '/tab')));
      },),
    );
  }
}


