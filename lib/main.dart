import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Stopwatch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stopwatch = Stopwatch();
  late Timer t;
  @override
  void initState() {
    super.initState();
    stopwatch.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                alignment: Alignment.center,
                height: 250,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 4)),
                child: Text(
                  stringFormatted(),
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                handleStartStop();
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  stopwatch.reset();
                  stopwatch.stop();
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
      t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
    }
  }

  String stringFormatted() {
    var milli = stopwatch.elapsedMilliseconds;
    String milliseconds = (milli % 1000).toString();
    String sec = ((milli ~/ 1000) % 60).toString();
    String min = ((milli ~/ 1000) ~/ 60).toString();
    return '$min : $sec.$milliseconds';
  }
}
