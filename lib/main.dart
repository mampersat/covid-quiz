import 'package:flutter/material.dart';
import 'dart:math';
import 'constants.dart';
import 'about_screen.dart';

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
      initialRoute: 'home',
      routes: {
        'home': (context) => MyHomePage(),
        'about': (context) => AboutScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  Animation<Offset> _offsetAnimation2;

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
    setState(() {
      risk1 = risks[random.nextInt(risks.length)];
      do {
        risk2 = risks[random.nextInt(risks.length)];
      } while (risk1 == risk2 || risk1.value == risk2.value);

      correctRisk = risk1.value > risk2.value ? risk1 : risk2;
      _controller.reverse();
    });
  }

  void checkAnswer(risk) async {
    setState(() {
      if (risk == correctRisk) {
        if (!lastGuessWrong) correct++;
        lastGuessWrong = false;
        color1 = Theme.of(context).canvasColor;
        color2 = Theme.of(context).canvasColor;
        _controller.forward();
        //setQuestion();
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
    super.initState();

    _controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: this); //..repeat();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('setting questions');
        setQuestion();
      }
    });
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));

    _offsetAnimation2 = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));

    setQuestion();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID 19 Risk Quiz'),
        actions: [
          FlatButton(
            child: Text('About'),
            onPressed: () {
              Navigator.pushNamed(context, 'about');
            },
          )
        ],
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
              child: SlideTransition(
                position: _offsetAnimation,
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
            ),
            Expanded(
              flex: 2,
              child: SlideTransition(
                position: _offsetAnimation2,
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
