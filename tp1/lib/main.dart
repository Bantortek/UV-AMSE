
import 'dart:convert'; 
  
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart' show rootBundle; 
  
void main() { 
  runApp(MyApp()); 
} 
  
class MyApp extends StatefulWidget { 
  @override 
  State<MyApp> createState() => _MyAppState(); 
} 
  
class _MyAppState extends State<MyApp> { 
  var jsonData;
  int _selectedIndex = 0;

  //=========================GESTION DU JSON==========================
  Future<void> loadJsonAsset() async { 
    final String jsonString = await rootBundle.loadString('assets/data.json'); 
    var data = jsonDecode(jsonString); 
    setState(() { 
      jsonData = data; 
    }); 
    //print(jsonData); 
  } 
  @override 
  void initState() { 
    // TODO: implement initState 
    super.initState(); 
    loadJsonAsset(); 
  } 

  List<Widget> buildWidgetsOfJson() {
    List<Widget> list = [];
    for (var i = 0; i < jsonData["movies"].length; i++) {
      list.add(Text("nom : ${jsonData["movies"][i]['title']}"));
    }
    List<Widget> _widgetOptions = <Widget>[
      ListView(
        padding: EdgeInsets.all(8),
        children: list,
      ),
      Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
      Text(
        'Index 3: Settings',
        style: optionStyle,
      ),
    ]; //===========================================================================WORKING HERE on fait que cette fct regénère tt les widgets
    return list;
  }
  //========================GESTION DE LA BARRE DE NAVIGATION===============
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  //======================================================================
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'My App', 
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(primarySwatch: Colors.green), 
      home: Scaffold( 
        appBar: AppBar( 
          title: Text('Filmothèque'), 
        ), 
        body: Center( 
            child: jsonData != null 
                ? _widgetOptions.elementAt(_selectedIndex)
                : CircularProgressIndicator()
        ), 
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        )
      ), 
    ); 
  } 
} 
