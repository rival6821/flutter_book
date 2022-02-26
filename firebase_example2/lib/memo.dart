import 'package:firebase_database/firebase_database.dart';

class Memo {
  String? key;
  String title;
  String content;
  String createTime;

  Memo(this.title, this.content, this.createTime);

  Memo.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.child('title').key.toString(),
        content = snapshot.child('content').key.toString(),
        createTime = snapshot.child('createTime').key.toString();

  toJson() {
    return {
      "title" : title,
      "content" : content,
      "createTime" : createTime,
    };
  }
}