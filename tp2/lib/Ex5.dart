import 'package:flutter/material.dart';

class ImageTile {
  String imagePath;
  int size;
  int i;


  ImageTile({required this.imagePath, required this.size, required this.i});

  Widget croppedImageTile() {
    double x = (i % size)/(size-1);
    double y = (i ~/ size)/(size-1);
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


class Ex5Page extends StatefulWidget {
  const Ex5Page({super.key});

  @override
  State<Ex5Page> createState() => _Ex5PageState();
}

class _Ex5PageState extends State<Ex5Page> {
  int grid_size = 2;
  
  Widget createTileWidgetFrom(ImageTile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
  
  GridView gridMaker(int size){
    List<Widget> tiles = [];
    for(var i = 0; i<size*size; i++){
      ImageTile tile = ImageTile(imagePath: 'assets/test_img.jpg', size:size, i:i);
      tiles.add(createTileWidgetFrom(tile));
    }
    GridView grid = GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
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