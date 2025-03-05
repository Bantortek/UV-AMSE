import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = math.Random();

class ColorTile {
  Color color = Colors.blue;
  int index = -1;

  ColorTile(this.color, this.index);
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
        child: Text(tile.index.toString(),style: TextStyle(fontSize: 25)),
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
      TileWidget tile;
      if(i == empty_space){
        tile = TileWidget(ColorTile(Colors.white,i));
      }else{
        tile = TileWidget(ColorTile(Colors.grey,i));
      }
      double x = (empty_space % size)/(size-1);
      double y = (empty_space ~/ size)/(size-1);
      Widget TouchableTile = InkWell(
      child: tile,
      onTap: () {
          print("yeah");
          if((x != 0 && tile.tile.index == empty_space -1)||(x != size-1 && tile.tile.index == empty_space +1)
           ||(y != 0 && tile.tile.index == empty_space - size)||(y != size-1 && tile.tile.index == empty_space + size)){
            print("yellow");
            setState(() {
              var tempty = tiles[empty_space];
              var tempindex = tiles[tile.tile.index];
              tiles.removeAt(tile.tile.index);
              tiles.insert(tile.tile.index, tempty);
              tiles.removeAt(empty_space);
              tiles.insert(empty_space, tempindex);
              
              //tiles.insert(tile.tile.index, temp);
              empty_space = tile.tile.index;
            });
          }

        }
      );
      tiles.add(TouchableTile);
    }
  }
}