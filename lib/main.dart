import 'package:flutter/material.dart';
import 'question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            title: Text("Info", style: TextStyle(color: Colors.white)),
          ),

          backgroundColor: Colors.grey[350],
          body: Padding(padding: const EdgeInsets.all(20.0), child: MyGame()),
        ),
      ),
    ),
  );
}

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  QuestionBrain brain = QuestionBrain();
  List<Widget> resultat = [];
  int correctAnswer = 0;
  bool gameState = true;
  int questionIndex = 0;

  void addButton(bool a) {
    setState(() {
      if (gameState != true) {
        return;
      }
      if (a == brain.q[questionIndex].getQuestionResultat()) {
        correctAnswer++;
        resultat.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.thumb_up, color: Colors.green),
          ),
        );
      } else {
        resultat.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.thumb_down, color: Colors.red),
          ),
        );
      }

      if (questionIndex >= brain.q.length - 1) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Game End",
          desc: "Resultat $correctAnswer / ${brain.q.length}",
          buttons: [
            DialogButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
            DialogButton(
              child: Text("Restart ?"),
              onPressed: () {
                setState(() {
                  resultat = [];
                  questionIndex = 0;
                  correctAnswer = 0;
                  gameState = true;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ).show();
        gameState = false;
      } else {
        questionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,

          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: resultat,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Image.asset(
                "Images/${brain.q[questionIndex].getQuestionImage()}",
              ),
              SizedBox(height: 20),
              Text(
                brain.q[questionIndex].getQuestionName(),
                style: TextStyle(color: Colors.black, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.zero),
                  ),
                ),
                onPressed: () {
                  addButton(true);
                },
                child: Text(
                  "True ",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15),

              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.zero),
                  ),
                ),
                onPressed: () {
                  addButton(false);
                },
                child: Text(
                  "False",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15),

              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.zero),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    resultat = [];
                    questionIndex = 0;
                    gameState = true;
                    correctAnswer = 0;
                  });
                },
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
