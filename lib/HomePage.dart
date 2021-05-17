import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODOS:import iamges
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");

  //TODOS:get an array
  List<String> itemArray;
  int luckyNumber, limit = 0;
  String message = "";

  //TODOS:init array with 25 elements
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }

  //limit method
  Limitmethod() {
    Future.delayed(const Duration(milliseconds: 2000),(){
       setState(() {
      this.resetGame();
      limit = 0;
    });
  });
   
  }
  //display message

  Displaymessage() {
    setState(() {
      message = "You have reached to maximum tries ! ";
      Limitmethod();
    });
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //TODOS:define getImage method
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return circle;
  }

  //TODOS:play game method
  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
        this.message = "You got Lucky!";
        Limitmethod();
      });
    } else if (luckyNumber != index && limit <= 5) {
      setState(() {
        itemArray[index] = "unlucky";
        limit++;
      });
    }
    if (limit == 5) {
      Displaymessage();
    }
  }

  //TODOS:showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  //TODOS:Reset all
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      this.message = "";
      this.limit = 0;
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          title: Text("Scratch And Win",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.white,
          
        ),
        
        body: Column(
          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: <Widget>[
             Container(
              padding: EdgeInsets.fromLTRB(125.0, 10.0, 10.0, 10.0),
              color: Colors.black,
              child: Text("Developed by Nency ",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            Expanded(
             
              child: GridView.builder(
                padding: EdgeInsets.all(20.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.0,
                    crossAxisCount: 5,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: itemArray.length,
                  itemBuilder: (context, i) => SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          this.playGame(i);
                        },
                        child: Image(
                          image: this.getImage(i),
                        ),
                      ))),
              ),
              Container(
              padding: EdgeInsets.fromLTRB(100.0, 20.0, 50.0, 20.0),
              child: Text(message,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
             children:<Widget> [
             Container(
              margin: EdgeInsets.all(15.0),
              child: RaisedButton(
                  onPressed: () {
                    this.showAll();
                  },
                  child: Text("Show All"),
                  color: Colors.white),
            ),
             Container(
              margin: EdgeInsets.all(15.0),
              child: RaisedButton(
                  onPressed: () {
                    this.resetGame();
                  },
                  child: Text("Reset"),
                  color: Colors.white),
            ),


               ],
              ),
              

            ),
            Container(
              padding: EdgeInsets.fromLTRB(125.0, 10.0, 10.0, 10.0),
              color: Colors.black,
              child: Text("LearnCodeOnline.in",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            
            
           
          ],
        ));
  }
}
