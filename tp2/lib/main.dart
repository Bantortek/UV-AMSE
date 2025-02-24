import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

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
  double speed = 0.01;
  double sliderValueX = 0;
  double sliderValueZ = 0;
  double sliderValueScale = 0.5;
  bool isMirrored = false;
  bool isAuto = false;
  Image img = Image.network("https://picsum.photos/512/1024", height: 500,);
  Image img_mod = Image.network("https://picsum.photos/512/1024", height: 500,);

  void animate(Timer t) {
    setState(() {
      sliderValueScale += speed;
      sliderValueX += speed;
      sliderValueZ += speed;
      if (sliderValueScale>1){
        sliderValueScale -=1;
      }
      if (sliderValueX>1){
        sliderValueX -=1;
      }
      if (sliderValueZ>1){
        sliderValueZ -=1;
      }
      t.cancel();
    });
      
  }
  @override
  Widget build(BuildContext context) {
    if(isAuto){
      const d = Duration(milliseconds: 50);
      Timer.periodic(d, animate);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Rotate/Resize image')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(color: Colors.white),
              child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.skewY(0)..rotateX(math.pi*2*sliderValueX),
                      child:Transform.scale(scale: 2*sliderValueScale,
                        child : Transform.rotate(angle: math.pi*2*sliderValueZ, 
                          child: Transform.flip(flipX: isMirrored, child: img_mod)
                          )
                        )
              ) 
          ),
          Slider(
            value: sliderValueX,
            onChanged: (double value) {
              setState(() {
                sliderValueX = value;
              });
            },
          ),
          Slider(
            value: sliderValueZ,
            onChanged: (double value) {
              setState(() {
                sliderValueZ = value;
              });
            },
          ),
          Checkbox(
            checkColor: Colors.white,
            value: isMirrored,
            onChanged: (bool? value) {
              setState(() {
                isMirrored = value!;
              });
            },
          ),
          Checkbox(
            checkColor: Colors.white,
            value: isAuto,
            onChanged: (bool? value) {
              setState(() {
                isAuto = value!;
              });
            },
          ),
          Slider(
            value: sliderValueScale,
            onChanged: (double value) {
              setState(() {
                sliderValueScale = value;
                print(value);
              });
            },
          ),
        ],
      ),
    );
  }
}
