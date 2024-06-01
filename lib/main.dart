import 'dart:async';

import 'package:flutter/material.dart';

import 'next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'タイマー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});  //イニシャライザ

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _second = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    // 1秒ごとに_secondを更新する
    _timer = Timer.periodic(
        Duration(seconds: 1), (timer) {
      setState(() {
        _second++;
      });
      if (_second == 10) {
        _timer?.cancel();
        _isRunning = false;

        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) {
                  return const NextPage();
                }
            )
        ).then((value) {
          setState(() {
            _second = 0;
          });
        });
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '$_second',
              style: TextStyle(fontSize: 64),
            ),
            ElevatedButton(
              onPressed: () {
                toggleTimer();
              },
              child: Text(
                  _isRunning ? 'ストップ' : 'スタート',
              style: TextStyle(
                color: _isRunning ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),)
            ),
            ElevatedButton(
                onPressed: () {
                  resetTimer();
                },
                child: Text('リセット',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),)
            ),
            // if
          ],
        ),
      ),
    );
  }

  void toggleTimer() {
    // タイマーをキャンセルする
    // タイマーが動いていない場合は何もしない
    // タイマーが動いている場合はキャンセルする
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _startTimer();
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _second = 0;
      _isRunning = false;
    });
  }
}
