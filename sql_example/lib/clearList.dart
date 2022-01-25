import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_example/todo.dart';

class ClearListApp extends StatefulWidget {
  Future<Database> database;
  ClearListApp(this.database);

  @override
  _ClearListApp createState() => _ClearListApp();
}

class _ClearListApp extends State<ClearListApp> {
  Future<List<Todo>>? clearList;

  @override
  void initState() {
    super.initState();
    clearList = getClearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('완료한 일'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Todo todo = (snapshot.data as List<Todo>)[index];
                        return ListTile(
                          title: Text(
                            todo.title!,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Container(
                            child: Column(
                              children: [
                                Text(todo.content!),
                                Container(height: 1, color: Colors.blue)
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  }
              }
              return Text('No data');
            },
            future: clearList,
          ),
        ),
      ),
    );
  }

  Future<List<Todo>> getClearList() async {
    final Database database = await widget.database;
    List<Map> maps = await database
        .rawQuery('select title, content, id from todos where active=1');
    return List.generate(
        maps.length,
        (i) => Todo(
            title: maps[i]['title'].toString(),
            content: maps[i]['title'].toString(),
            id: maps[i]['id']));
  }
}
