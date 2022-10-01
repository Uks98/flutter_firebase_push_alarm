import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_exam/page/memoAddPage.dart';
import 'package:firebase_exam/page/memoDetail.dart';
import 'package:flutter/material.dart';

import '../data/memo.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String databaseUrl = "https://fir-examdoit-default-rtdb.firebaseio.com";
  List<Memo> memos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = FirebaseDatabase(databaseURL: databaseUrl);
    reference = _database!.reference().child("memo");

    reference!.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MemoAddPage(reference: reference)));
        },
      ),
      appBar: AppBar(title: Text("파이어 베이스 메모앱")),
      body: Container(
        child: Center(
          child: memos.length == 0
              ? CircularProgressIndicator()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: SizedBox(
                            child: GestureDetector(
                              onTap: () async{
                                Memo memo = await Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MemoDetailPage(
                                        reference: reference,
                                        memo: memos[index])));
                                if(memo != null){
                                  setState((){
                                    memos[index].title = memo.title;
                                    memos[index].content = memo.content;
                                  });
                                }
                              },
                              onLongPress: () {
                                reference!.child(memos[index].key.toString()).remove();
                                setState((){
                                  memos.removeAt(index);
                                });
                              },
                              child: Text(
                                memos[index].content.toString(),
                              ),
                            ),
                          ),
                        ),
                        header: Text(
                          memos[index].title.toString(),
                        ),
                        footer: Text(
                          memos[index].createTime.toString().substring(0, 10),
                        ),
                      ),
                    );
                  },
                  itemCount: memos.length,
                ),
        ),
      ),
    );
  }
}
