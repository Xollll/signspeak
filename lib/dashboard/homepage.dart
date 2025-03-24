import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Text("Selamat Datang di SignSpeak", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
    );
  }
}