
import 'dart:convert';
import 'dart:io'; 
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart' show rootBundle; 
  
void main() { 
  runApp(MaterialApp(title: 'Marmitonne', home: MyApp())); 
} 
  
class MyApp extends StatefulWidget { 
  @override 
  State<MyApp> createState() => _MyAppState(); 
} 
  
class _MyAppState extends State<MyApp> { 
  var jsonData;
  // late TextEditingController _controller;
  // late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;

  //=========================LECTURE DU JSON==========================
  Future<void> loadJsonAsset() async { 
    final String jsonString = await rootBundle.loadString('assets/Recipes.json'); 
    var data = jsonDecode(jsonString); 
    setState(() { 
      jsonData = data; 
    }); 
  } 
  @override 
  void initState() { 
    super.initState(); 
    // _controller = TextEditingController();
    loadJsonAsset(); 
  } 
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
  //============================ECRITURE DU JSON====================
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/assets/Recipes.json');
  }
  Future<File> writeJson() async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(jsonData));
  }
  //===================Constructions des différentes pages=======================
  List<Widget> buildWidgetsOfJson() {
    //____Liste complète____
    ListView full_list = ListView.builder(
      shrinkWrap: true,
      itemCount: jsonData.length,
      itemBuilder: (_, int index) {
        num prep_time = 0;
        for(num i = 0; i < jsonData[index]["timers"].length; i++){
          prep_time += jsonData[index]["timers"][i]!;
        }
        return ListTile(
          leading: Image.network(jsonData[index]["imageURL"], width: 75),
          title: Text(jsonData[index]['name']),
          subtitle: Text("Prep Time: $prep_time minutes"),
          trailing: IconButton(
            icon: jsonData[index]["is_fav"] == 1 
                    ? Icon(Icons.favorite) 
                    : Icon(Icons.favorite_border_outlined),
            onPressed: () {
              setState(() {
                jsonData[index]["is_fav"] = 1 - jsonData[index]["is_fav"];
                writeJson();
              });
            },
          ),
          
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute(recipe: jsonData[index],)),
            );
          },
        );
      },
    );
    //____Liste favoris____
    final favIndexes = <int>[];
    for(int i = 0; i<jsonData.length; i++){
      if(jsonData[i]['is_fav'] == 1){
        favIndexes.add(i);
      }
    }
    ListView fav_list = ListView.builder(
      shrinkWrap: true,
      itemCount: favIndexes.length,
      itemBuilder: (_, int index) {
        num prep_time = 0;
        for(num i = 0; i < jsonData[favIndexes[index]]["timers"].length; i++){
          prep_time += jsonData[favIndexes[index]]["timers"][i]!;
        }
        return ListTile(
          leading: Image.network(jsonData[favIndexes[index]]["imageURL"], width: 75),
          title: Text(jsonData[favIndexes[index]]['name']),
          subtitle: Text("Prep Time: $prep_time minutes"),
          trailing: IconButton(
            icon: jsonData[favIndexes[index]]["is_fav"] == 1 
                    ? Icon(Icons.favorite) 
                    : Icon(Icons.favorite_border_outlined),
            onPressed: () {
              setState(() {
                jsonData[favIndexes[index]]["is_fav"] = 1 - jsonData[favIndexes[index]]["is_fav"];
                writeJson();
              });
            },
          ),
          
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute(recipe: jsonData[index],)),
            );
          },
        );
      },
    );
    //____Liste cherchés____
    // List<int> searchIndexes = <int>[];
    // ListView search_list = ListView(key: _formKey, children: [Text("a")],);
    // var txtfld = TextField(
    //       controller: _controller,
    //       decoration: InputDecoration(
    //         hintText: 'Search',
    //         hintStyle: TextStyle(color: Colors.grey),
    //       ),
    //       onSubmitted: (String value) async {
    //         searchIndexes = <int>[];
    //         for(int i = 0; i<jsonData.length; i++){
    //           if(jsonData[i]['name'].contains(value)){
    //             searchIndexes.add(i);
    //           }
    //         }
    //         print(searchIndexes);
    //         search_list = ListView.builder(
    //                         key: _formKey,
    //                         shrinkWrap: true,
    //                         itemCount: searchIndexes.length,
    //                         itemBuilder: (_, int index) {
    //                           print(searchIndexes);
    //                           num prep_time = 0;
    //                           for(num i = 0; i < jsonData[searchIndexes[index]]["timers"].length; i++){
    //                             prep_time += jsonData[searchIndexes[index]]["timers"][i]!;
    //                           }
    //                           return ListTile(
    //                             leading: Image.network(jsonData[searchIndexes[index]]["imageURL"], width: 75),
    //                             title: Text(jsonData[searchIndexes[index]]['name']),
    //                             subtitle: Text("Prep Time: $prep_time minutes"),
    //                             trailing: IconButton(
    //                               icon: jsonData[searchIndexes[index]]["is_fav"] == 1 
    //                                       ? Icon(Icons.favorite) 
    //                                       : Icon(Icons.favorite_border_outlined),
    //                               onPressed: () {
    //                                 setState(() {
    //                                   jsonData[searchIndexes[index]]["is_fav"] = 1 - jsonData[searchIndexes[index]]["is_fav"];
    //                                   writeJson();
    //                                 });
    //                               },
    //                             ),                        
    //                             onTap: () {
    //                               Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(builder: (context) => SecondRoute(recipe: jsonData[index],)),
    //                               );
    //                             },
    //                           );
    //                         },
    //                       );
    //       }
    //     );
    

    List<Widget> widgetOptions = <Widget>[
      Column(
          children: [Text("Recipes", textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ) ),
          Expanded(child: full_list)]
      ),
      Column(
          children: [Text("Favorites", textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ) ),
          Expanded(child: fav_list)]
      ),
      // Column(
      //     children: [
      //       Text("Search a recipe", textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20 )),
      //       Padding(padding: EdgeInsets.all(16), child: txtfld,),
      //       Expanded(child: search_list)
      //     ]
      //   )
      // ,
      Padding(padding: EdgeInsets.all(16),
        child:Column(
          children: [
            Text('App by Alban AMEYE as a project for the AMSE module at IMTNE'),
            Text('Recipes powered by Mistral', style: TextStyle(fontStyle: FontStyle.italic))
          ]
        )
      ),
    ]; 
    return widgetOptions;
  }
  //========================GESTION DE LA BARRE DE NAVIGATION===============
  

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
          title: Text('Marmitonne'), 
        ), 
        body: Center( 
            child: jsonData != null 
                ? buildWidgetsOfJson().elementAt(_selectedIndex)
                : CircularProgressIndicator()
        ), 
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Recipes',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
              backgroundColor: Colors.red,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.search),
            //   label: 'Search',
            //   backgroundColor: Colors.purple,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Infos',
              backgroundColor: Colors.cyan,
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

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key, required this.recipe});

  final dynamic recipe;
  @override
  Widget build(BuildContext context) {
    List<Widget> laRecette = [Image.network(recipe["imageURL"], width: 300),
                              Text("Ingredients", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ) ),
                              Column(children: [Row(children: [
                                Expanded(child:Text("Name", style: const TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(child:Text("Quantity", style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right))
                              ])
                              ])
                              ];

    for(int i = 0; i< recipe["ingredients"].length; i++){
      laRecette.add(Row(children : [
        Expanded(child:Text(recipe["ingredients"][i]["name"])),
        Expanded(child:Text(recipe["ingredients"][i]["quantity"], textAlign: TextAlign.right))
        ]));
    }
    laRecette.add(Text("Recipe", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ) ));

    for(int i = 0; i< recipe["steps"].length; i++){
      // laRecette.add(Row(children : [
      //   Expanded(child:Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      //       child: Row(children : [Text(recipe["steps"][i]),Text(recipe["timers"][i].toString(), textAlign: TextAlign.right)])
      //       ))
      //   ]));
      laRecette.add(Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                                  child : Row(children : [Expanded(flex: 6, child: Text(recipe["steps"][i])),
                                    Expanded(flex: 1, child: Text("${recipe["timers"][i]} min", textAlign: TextAlign.right))]
                                    )
                                  )
                    );

    }
    return Scaffold(
      appBar: AppBar(title: Text(recipe["name"])),
      body: SingleChildScrollView(
        child:Center(
          child: Padding(padding: EdgeInsets.all(16.0),child: Column(children: laRecette))
          )
        )
      );
  }
}