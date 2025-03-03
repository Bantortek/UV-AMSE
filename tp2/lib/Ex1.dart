import 'package:flutter/material.dart';

class Ex1Page extends StatefulWidget {
  const Ex1Page({super.key});

  @override
  State<Ex1Page> createState() => _Ex1PageState();
}

class _Ex1PageState extends State<Ex1Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Display a picture from URL"),
      ),
      body: Image.network("https://picsum.photos/512/1024"),
    );
  }
}