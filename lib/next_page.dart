import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('10秒経過しました！',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        )),
      )
    );
  }
}
