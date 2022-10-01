import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_exam/data/memo.dart';
import 'package:flutter/material.dart';

class MemoDetailPage extends StatefulWidget {
  final DatabaseReference? reference;
  final Memo? memo;

  const MemoDetailPage({Key? key, required this.reference, required this.memo})
      : super(key: key);

  @override
  State<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.memo!.title);
    contentController = TextEditingController(text: widget.memo!.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.memo!.title.toString())),
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
            ElevatedButton(
                onPressed: () {
                  Memo memo = Memo(titleController.text, contentController.text,
                      widget.memo?.createTime.toString());
                  widget.reference!
                      .child(widget.memo!.key.toString())
                      .set(memo.toJson())
                      .then((_) => Navigator.of(context).pop(memo));
                },
                child: Text("수정하기"))
          ],
        ),
      ),
    );
  }
}
