import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = math.Random();

class ColorTile {
  Color color = Colors.blue;
  int position = -1;
  int value = -1;

  ColorTile(this.color, this.position, this.value);
  ColorTile.randomColor() {
    color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

// ==============
// Widgets
// ==============

class TileWidget extends StatelessWidget {
  final ColorTile tile;

  const TileWidget(this.tile,{super.key});

  @override
  Widget build(BuildContext context) {
    return coloredBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        child: Column( children:[
          Text(tile.value.toString(),style: TextStyle(fontSize: 25)),
        ])
        );
  }
}

void main() => runApp(MaterialApp(home: Ex6Page()));

class Ex6Page extends StatefulWidget {
  const Ex6Page({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<Ex6Page> {
  List<Widget> tiles = [];
  int grid_size = 3;
  int empty_space = -1;
  PositionedTilesState(){
    empty_space = math.Random().nextInt(grid_size*grid_size);
    tilesMaker(grid_size);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moving Tiles'),backgroundColor: Colors.greenAccent,),
      body:GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              crossAxisCount: grid_size,
              children: [...tiles]
            ),
    );
  }


  void tilesMaker(int size){
    tiles = [];
    for(var i = 0; i<size*size; i++){
      Widget tile;
      if(i == empty_space){
        tile = TileWidget(ColorTile(Colors.white,i,i));
      }else{
        TileWidget pre_tile = TileWidget(ColorTile(Colors.grey,i,i));
        tile = InkWell(
          child: pre_tile,
          onTap: () {
              int x = (empty_space % size);
              int y = (empty_space ~/ size);
              if((x != 0 && pre_tile.tile.position == empty_space -1)||(x != size-1 && pre_tile.tile.position == empty_space +1)
              ||(y != 0 && pre_tile.tile.position == empty_space - size)||(y != size-1 && pre_tile.tile.position == empty_space + size)){
                setState(() {
                  Widget tempty = tiles[empty_space];
                  Widget tempindex = tiles[pre_tile.tile.position];
                  tiles.removeAt(pre_tile.tile.position);
                  tiles.insert(pre_tile.tile.position, tempty);
                  tiles.removeAt(empty_space);
                  tiles.insert(empty_space, tempindex);
                  
                  int temp_index = pre_tile.tile.position;
                  pre_tile.tile.position = empty_space;
                  empty_space = temp_index;
                });
              }

            }
        );
      }
      tiles.add(tile);
    }
  }
}