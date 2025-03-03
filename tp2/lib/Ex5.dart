import 'package:flutter/material.dart';

class Ex5Page extends StatefulWidget {
  const Ex5Page({super.key});

  @override
  State<Ex5Page> createState() => _Ex5PageState();
}

class _Ex5PageState extends State<Ex5Page> {
  int grid_size = 2;
  
  
  GridView gridMaker(int size){
    List<Widget> tiles = [];
    for(var i = 0; i<size*size; i++){
      tiles.add(Container(
            padding: const EdgeInsets.all(8),
            color: Colors.green[100],
            child: Text("Case $i"),
          ),);
    }
    GridView grid = GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: size,
              children: tiles
            );
    return grid;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Display a picture from URL"),
      ),
      body: Column(children: [gridMaker(grid_size),
                              Slider(
                                min: 2,
                                max: 10,
                                divisions: 10,
                                label: grid_size.toString(),
                                value: grid_size.roundToDouble(),
                                onChanged: (double value) {
                                  setState(() {
                                    grid_size = value.round();
                                  });
                                }
                              )
      ]),

    );
  }
}