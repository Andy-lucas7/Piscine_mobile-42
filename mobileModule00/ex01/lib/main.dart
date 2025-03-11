import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: const MyButton()),
    );
  }
}

class MyButton extends StatefulWidget {
  const MyButton({super.key});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isOriginalText = true;

  void toggleText() {
    setState(() {
      isOriginalText = !isOriginalText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 197, 131),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              isOriginalText ? "Press the button" : "Hello word!",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: toggleText,
            child: const Text("Press", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
