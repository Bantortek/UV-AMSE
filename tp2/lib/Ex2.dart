import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class Ex2Page extends StatefulWidget {
  const Ex2Page({super.key});

  @override
  State<Ex2Page> createState() => _Ex2PageState();
}

class _Ex2PageState extends State<Ex2Page> {
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
      appBar: AppBar(title: const Text('Rotate/Resize image'),backgroundColor: Colors.greenAccent,),
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
          Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child :Row(children: [Text("RotateX: "),
                          Slider(
                            value: sliderValueX,
                            onChanged: (double value) {
                              setState(() {
                                sliderValueX = value;
                              });
                            },
                          )],
          )),
          Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child :Row(children: [Text("RotateZ: "),
                          Slider(
                            value: sliderValueZ,
                            onChanged: (double value) {
                              setState(() {
                                sliderValueZ = value;
                              });
                            },
                          )]
          )),
          Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child : Row(children: [Text("Mirror: ") , 
                                          Checkbox(
                                            checkColor: Colors.white,
                                            value: isMirrored,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isMirrored = value!;
                                              });
                                            },
                                          ),
                      ])
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child : Row(children: [Text("Scale: ") ,
                          Slider(
                            value: sliderValueScale,
                            onChanged: (double value) {
                              setState(() {
                                sliderValueScale = value;
                                print(value);
                              });
                            },
                          )]
                        )
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child : Row(children: [Text("Animate", textAlign: TextAlign.right,) , 
                                        Checkbox(
                                          checkColor: Colors.white,
                                          value: isAuto,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isAuto = value!;
                                            });
                                          },
                                        )
                      ])
          )
        ],
      ),
    );
  }
}