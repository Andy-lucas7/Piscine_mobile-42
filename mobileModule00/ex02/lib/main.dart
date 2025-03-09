import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Expanded customButton(String text, Color color) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          print(text);
        },
        style: TextButton.styleFrom(foregroundColor: color),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calculator',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 83, 98, 114),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 41, 47, 51),
                ),
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "0",
                          style: const TextStyle(
                            fontSize: 44,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          " ",
                          style: const TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 83, 98, 114),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customButton('7', Colors.black),
                          customButton('8', Colors.black),
                          customButton('9', Colors.black),
                          customButton('C', Colors.red),
                          customButton('AC', Colors.red),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customButton('4', Colors.black),
                          customButton('5', Colors.black),
                          customButton('6', Colors.black),
                          customButton('+', Colors.white),
                          customButton('-', Colors.white),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customButton('1', Colors.black),
                          customButton('2', Colors.black),
                          customButton('3', Colors.black),
                          customButton('x', Colors.white),
                          customButton('/', Colors.white),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customButton('0', Colors.black),
                          customButton('.', Colors.black),
                          customButton('00', Colors.black),
                          customButton('=', Colors.white),
                          Expanded(
                            child: TextButton(
                              onPressed: null,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                '',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
