import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_exam/data/memo.dart';
import 'package:flutter/material.dart';

class MemoAddPage extends StatefulWidget {
  final DatabaseReference? reference;

  MemoAddPage({Key? key, required this.reference}) : super(key: key);

  @override
  State<MemoAddPage> createState() => _MemoAddPageState();
}

class _MemoAddPageState extends State<MemoAddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메모추가")),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: "제목", fillColor: Colors.blueAccent),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: 20,
                decoration: InputDecoration(
                    labelText: "내용", fillColor: Colors.blueAccent),
              ),
            ),
            ElevatedButton(onPressed: (){
              widget.reference!.push().set(
                  Memo(
                    titleController.text,
                    contentController.text,
                     DateTime.now().toIso8601String()).toJson()).then((_){
                    Navigator.of(context).pop();
              });
            }, child: Text("저장하기"))
          ],
        ),
      ),
    );
  }
}
