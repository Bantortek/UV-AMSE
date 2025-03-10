import 'package:flutter/material.dart';
import 'pageImport.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('TP2'), backgroundColor: Colors.greenAccent,),
      body:ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              ListTile(
                title: Text("Ex 1"),
                subtitle: Text("Display a picture from URL"),
                trailing: Icon(Icons.play_arrow),                 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ex1Page()),
                  );
                },
              ),
              ListTile(
                title: Text("Ex 2"),
                subtitle: Text("Rotate/resize Image"),
                trailing: Icon(Icons.play_arrow),                 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ex2Page()),
                  );
                },
              ),
              ListTile(
                title: Text("Ex 4"),
                subtitle: Text("Display a Tile as a Cropped Imagee"),
                trailing: Icon(Icons.play_arrow),                 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ex4Page()),
                  );
                },
              ),
              ListTile(
                title: Text("Ex 5"),
                subtitle: Text("Generate a grid"),
                trailing: Icon(Icons.play_arrow),                 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ex5Page()),
                  );
                },
              ),
              ListTile(
                title: Text("Ex 6"),
                subtitle: Text("move tiles on a grid"),
                trailing: Icon(Icons.play_arrow),                 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ex6Page()),
                  );
                },
              ),
              ListTile(
                title: Text("Ex 7"),
                subtitle: Text("Taquin"),
                trailing: Icon(Icons.play_arrow),                 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ex7Page()),
                  );
                },
              )
            ])
    );
  }
}
