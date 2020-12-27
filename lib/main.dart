import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scratch and win",
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //todo:import images;

  AssetImage circle   = AssetImage('assets/circle.png');
  AssetImage lucky    = AssetImage('assets/rupee.png');
  AssetImage unlucky  = AssetImage('assets/sadFace.png');

  //todo:get an array;

  List<String> itemArray;
  int luckyNumber;
  int totalTurns;

  int chances;



  //todo:initialize array with 25 elements;

  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => 'empty');
  totalTurns = 5;
  chances = totalTurns;
    generateRandomNumber();

}

  generateRandomNumber(){
    int random = Random().nextInt(25);
    print(random);
    setState(() {
      luckyNumber = random;
      chances = totalTurns;
    });
  }

  //todo:getimage method;
  AssetImage getImage(int index)
  {
    String currentState = itemArray[index];

    switch(currentState)
    {
      case 'lucky':
        return lucky;
        break;

      case 'unlucky':
        return unlucky;
        break;


    }return circle;

  }
dialog(String res)
{
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Alert Dialog"),
          content: Text('$res'),
          actions: [
            FloatingActionButton(
              child: Text(
                'ok',
              ),
              onPressed: (){
                Navigator.of(context).pop();
                resetGame();
              },
            )
          ],
        );

      }

  );

}
  //todo:play game method

  playGame(int index)
  {
    totalTurns = totalTurns-1;
    chances = totalTurns;
    if(luckyNumber==index)
      {
        setState(() {
          itemArray[index] = "lucky";
          dialog("win");
        });
      }
    else {
      setState(() {
        itemArray[index] = "unlucky";

      });
    }
    if(totalTurns==0)
      dialog("lost");
  }
  //todo:show all
  showAll()
  {
    setState(() {
      itemArray = List.filled(25, 'unlucky');
      itemArray[luckyNumber] = 'lucky';
      chances = 0;
    });
  }

  //todo:reset game

  resetGame(){
    setState(() {
      itemArray = List<String>.filled(25, 'empty');
      chances = 5;
    });

    generateRandomNumber();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scratch and win..',
        ),
      ),
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(15.0),
            child: Text(
              'you have $chances left'
            )
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount: 5,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
              itemCount: 25,
              itemBuilder: (context ,i)=>SizedBox(
                
                width: 50.0,
                height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      playGame(i);
                    },
                    child: Image(
                      image: this.getImage(i),
                    ),
                  ),
                
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: (){
                this.showAll();
              },
              color: Colors.pink,
              child: Text(
                  'Show all'
              )

            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: (){
                this.resetGame();
              },
             color: Colors.pink,
              child: Text(
                'Reset Game'
              )

            ),
          ),
        ],
      ),
    );
  }
}
