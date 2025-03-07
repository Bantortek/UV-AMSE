import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============


class ColorTile {
  Color color = Colors.blue;
  int position = -1;
  int value = -1;

  ColorTile(this.color, this.position, this.value);
}

class ImageTile {
  String imagePath;
  int size;
  int position = -1;
  int value = -1;


  ImageTile({required this.imagePath, required this.size, required this.position, required this.value});

  Widget croppedImageTile() {
    double x = (value % size)/(size-1);
    double y = (value ~/ size)/(size-1);
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Align(
          alignment: FractionalOffset(x, y),
          widthFactor: 1/size,
          heightFactor: 1/size,
          child: Image(image: AssetImage(imagePath)),
        ),
      ),
    );
  }
}

// ==============
// Widgets
// ==============

class TileWidget extends StatelessWidget {
  final dynamic tile;

  const TileWidget(this.tile, {super.key});

  @override
  Widget build(BuildContext context) {
    return coloredBox();
  }

  Widget coloredBox() {

    return Container(
        child: tile is ImageTile 
              ? Stack(
                alignment: Alignment.bottomRight,
                children: [tile.croppedImageTile(),Text("", style: TextStyle(color: Colors.black, fontSize: 20),)],
              )
              : Text("")
        
        );
  }
}

//void main() => runApp(MaterialApp(home: Ex6Page()));

class Ex7Page extends StatefulWidget {
  const Ex7Page({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<Ex7Page> {
  List<Widget> tiles = [];
  int grid_size = 2;
  int empty_space = -1;
  bool onBuild = true;
  int img_num = 1;
  int mvt_count = 0;
  PositionedTilesState(){
    empty_space = math.Random().nextInt(grid_size*grid_size);
    img_num = math.Random().nextInt(5)+1;
    tilesMaker(grid_size);
  }
  
  @override
  Widget build(BuildContext context) {

    if(onBuild){
      tilesShaker();
      onBuild = false;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Taquin'),backgroundColor: Colors.greenAccent,),
      body:Column(children: [
        Container(
          alignment: Alignment.bottomLeft,
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Nombre de movements réalisés : ${mvt_count.toString()}", style: TextStyle(fontSize: 15),),),
        ),
        Stack(alignment: Alignment.center,
              children: [GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          crossAxisCount: grid_size,
                          children: [...tiles]
                        ),
                        Text("YOU WIN", style: TextStyle(color: areTilesInOrder() 
                                                ? Colors.yellow
                                                : Colors.transparent,
                                                fontSize: 50,
                                                backgroundColor: areTilesInOrder() 
                                                ? Colors.red
                                                : Colors.transparent,
                        ),)
        ],),
        Container(
          alignment: Alignment.bottomLeft,
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Text("Taille du Taquin :", style: TextStyle(fontSize: 15),),),
        ),
        Slider(
              min: 2,
              max: 10,
              divisions: 10,
              label: grid_size.toString(),
              value: grid_size.roundToDouble(),
              onChanged: (double value) {
                setState(() {
                  empty_space = 0;
                  grid_size = value.round();
                  tilesMaker(grid_size);
                  tilesShaker();
                });
              }
            ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              child: Text("changer l'image"),
              onPressed: () {
                setState(() {
                  img_num++;
                  if(img_num>5){
                    img_num = 1;
                  }
                  tilesMaker(grid_size);
                  tilesShaker();
                });
              },
            ),
          ),
        ),
      ]),
    );
  }


  void tilesMaker(int size){
    tiles = [];
    for(var i = 0; i<size*size; i++){
      Widget tile;
      if(i == empty_space){
        tile = TileWidget(ColorTile(Colors.white,i,i));
      }else{
        TileWidget pre_tile = TileWidget(ImageTile(imagePath: 'assets/image_${img_num.toString()}.png', size:size, position: i, value: i));
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
                  mvt_count +=1;
                });
              }

            }
        );
      }
      tiles.add(tile);
    }
  }

void tilesShaker() {
  int iter = grid_size*grid_size*10;
  while(iter>0){
    bool axe = math.Random().nextBool(); //True = x, False = y
    bool side = math.Random().nextBool();//True = devant, False = derrière
    int toMoveIndex = -1;
    if(axe && side){
      toMoveIndex = empty_space + 1;
    }
    if(axe && !side){
      toMoveIndex = empty_space - 1;
    }
    if(!axe && side){
      toMoveIndex = empty_space + grid_size;
    }
    if(!axe && !side){
      toMoveIndex = empty_space - grid_size;
    }
    int x = (empty_space % grid_size);
    int y = (empty_space ~/ grid_size);
    if((x != 0 && axe && !side)||(x != grid_size-1 && axe && side)
    ||(y != 0 && !axe && !side)||(y != grid_size-1 && !axe && side)){
      setState(() {
        Widget tempty = tiles[empty_space];
        Widget tempindex = tiles[toMoveIndex];

        tiles[empty_space] = tempindex;
        tiles[toMoveIndex] = tempty;

        (((tiles[empty_space] as InkWell).child as TileWidget).tile as ImageTile).position = empty_space;
        ((tiles[toMoveIndex] as TileWidget).tile as ColorTile).position = toMoveIndex;

        empty_space = toMoveIndex;
        mvt_count = 0;
      });
      iter = iter -1;
    }
  }
}

bool areTilesInOrder() {
  for (int i = 0; i < tiles.length; i++) {
    if (tiles[i] is InkWell) {
      ImageTile imageTile = ((tiles[i] as InkWell).child as TileWidget).tile as ImageTile;
      if (imageTile.value != i) {
        return false;
      }
    }else if ((tiles[i] as TileWidget).tile is ColorTile) {
      ColorTile colorTile = (tiles[i] as TileWidget).tile as ColorTile;
      if (colorTile.value != empty_space) {
        return false;
      }
    }
  }
  return true;
}


}