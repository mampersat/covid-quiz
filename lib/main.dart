import 'package:flutter/material.dart';
import 'dart:math';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Risk Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'COVID19 Risk Quiz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final random = new Random();
  Risk risk1, risk2, correctRisk;
  int correct = 0, incorrect = 0;
  Color color1 = Colors.white;
  Color color2 = Colors.white;

  bool lastGuessWrong = false;

  void resetScore() {
    setState(() {
      correct = 0;
      incorrect = 0;
      lastGuessWrong = false;
    });
  }

  void setQuestion() {
    risk1 = risks[random.nextInt(risks.length)];
    do {
      risk2 = risks[random.nextInt(risks.length)];
    } while (risk1 == risk2 || risk1.value == risk2.value);

    correctRisk = risk1.value > risk2.value ? risk1 : risk2;
  }

  void checkAnswer(risk) {
    setState(() {
      if (risk == correctRisk) {
        if (!lastGuessWrong) correct++;
        lastGuessWrong = false;
        color1 = Theme.of(context).canvasColor;
        color2 = Theme.of(context).canvasColor;
        setQuestion();
      } else {
        incorrect++;
        if (risk1 == correctRisk)
          color1 = Colors.red;
        else
          color2 = Colors.red;
        lastGuessWrong = true;
      }
    });
  }

  @override
  void initState() {
    setQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  'Which is more risky',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 20.0,
                  child: FlatButton(
                    child: Text(risk1.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30.0)),
                    onPressed: () {
                      checkAnswer(risk1);
                    },
                    color: color1,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 20.0,
                  child: FlatButton(
                    child: Text(
                      risk2.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0),
                    ),
                    color: color2,
                    onPressed: () {
                      checkAnswer(risk2);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Right: $correct', style: TextStyle(fontSize: 25.0)),
                  Text('Wrong: $incorrect', style: TextStyle(fontSize: 25.0)),
                  OutlineButton(
                    child: Text('Reset'),
                    onPressed: resetScore,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
