
import 'package:firebase_database/firebase_database.dart';

class Memo{
  String? key;
  String? title;
  String? content;
  String? createTime;
  Memo(this.title,this.content,this.createTime);

   Memo.fromSnapshot(DataSnapshot snapshot){
     final data = snapshot.value as Map?;
     if(data != null){
       key = snapshot.key.toString();
       title = data["title"];
     content =  data["content"];
     createTime =  data["createTime"];
     }

   }



    Map<String,dynamic> toJson() {
      return {
        'content':content,
        'createTime':createTime,
        'title':title};
    }
    }