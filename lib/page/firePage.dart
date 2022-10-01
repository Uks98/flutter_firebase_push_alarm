import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class FireBasePage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  FireBasePage({Key? key,required this.analytics,required this.observer}) : super(key: key);

  @override
  State<FireBasePage> createState() => _FireBasePageState();
}

class _FireBasePageState extends State<FireBasePage> {
  String _message = "";

  void sendMessage(String message){
    setState((){
      _message = message;
    });
  }
  Future<void> _sendAnalyticsEvent()async{
    //에널리틱스의 로그이벤트를 호출해 테스트이벤트 키값으로 데이터 저장
    await widget.analytics.logEvent(
        name: "test_event",
    parameters: <String,dynamic> {
      "string" : "hello firebase",
      "int" : 100,
    }
    );
    sendMessage("메세지 전송 성공");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("firebase example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _sendAnalyticsEvent, child: Text("테스트 시작하기"),),
            Text(_message,style: TextStyle(color: Colors.blueAccent),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},child: Icon(Icons.tab),
      ),
    );
  }
}
