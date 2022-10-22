import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:tts_quiz/speech_api.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'appbar.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blueGrey),
        useMaterial3: true,
        shadowColor: Colors.redAccent,
        primaryColor: Colors.green,
        primarySwatch: Colors.blue,
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
  late stt.SpeechToText _speech;
  bool _islistening = false;

  String text = 'Press to start listening ';

  @override
  void initState() {
    // TODO: implement initState
    _speech = stt.SpeechToText();
    super.initState();
  }
FlutterTts flutterTts = FlutterTts();
  var questions = const [
    {'questiontxt': 'The value of 2 x 0 is ', 'ans': 'zero 0'},
    {'questiontxt': 'The value of 2 x 1 is', 'ans': 'one 2'},
    {'questiontxt': 'The value of 2 x 2 is', 'ans': 'four 4'},
    {'questiontxt': 'The value of 2 x 3 is', 'ans': 'six 6'},
    {'questiontxt': 'The value of 2 x 4 is', 'ans': 'eight 8'},
    {'questiontxt': 'The value of 2 x 5 is', 'ans': 'ten 10'},
    {'questiontxt': 'The value of 2 x 6 is', 'ans': 'twelve 12'},
    {'questiontxt': 'The value of 2 x 7 is', 'ans': 'fourteen 14'},
    {'questiontxt': 'The value of 2 x 8 is', 'ans': 'sixteen 16 '},
    {'questiontxt': 'The value of 2 x 9 is', 'ans': 'eigthteen 18 '},
    {'questiontxt': 'The value of 2 x 10 is', 'ans': 'twenty 20'}
  ];
  int index = 0;
  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
  void _resetquiz() {
    setState(() {
      index = 0;
    });
  }


  String ans = 'speak to answer';


  Future toggleRecording() => speechapi.tooglerecording(
      onresult: (text) {
        setState(() {
          this.text = text;
        });
        if (questions[index]['ans']!.contains(text)) {
          setState(() async{
            ans = 'correct';

// _islistening = !_islistening ;_islistening

          });
        } else  {
          setState(() async{
            ans = 'incorrect';


          });
        }
      },
      onListening: (islistening) => setState(() {
            this._islistening = islistening;
          }));

  void speech()async{
    if(ans=='correct')
      setState(() async{
        await flutterTts.speak(ans);
      });

    else
      setState(()async {
        await flutterTts.speak(ans);
      });


  }

  void _movetoNext() {
    setState(() {
      index = index + 1;
      text = 'Press to start listening ';
      ans = 'speak to answer';

    });
  }



  @override
  Widget build(BuildContext context) {
    speak() async{
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1);
      await flutterTts.speak(
      questions[index]['questiontxt'].toString());

    }
flutterTts.setCancelHandler(() {
  setState(() {

    flutterTts = flutterTts.stop() as FlutterTts;
  });
});
    return Scaffold(
        appBar: CustomAppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info))],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _movetoNext,
          icon: Icon(Icons.navigate_next_rounded),
          label: Text('Next'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                index < questions.length
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              children: [
                                Text(
                                  questions[index]['questiontxt'].toString(),
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Flexible(
                                fit: FlexFit.tight,
                                  child: IconButton(
                                      onPressed: ()=>speak(),
                                      
                                      icon: Icon(Icons.play_circle ,size: 40,)),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 35),
                            ),
                          ),
                          AvatarGlow(
                            glowColor: Colors.orange,
                            endRadius: 70.0,
                            repeat: true,
                            showTwoGlows: true,
                            child: Material(
                              // Replace this child with your own
                              elevation: 8.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                child: IconButton(
                                    onPressed: toggleRecording,
                                    icon: !_islistening
                                        ? Icon(
                                            Icons.mic,
                                            size: 30,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            Icons.stop,
                                            size: 30,
                                            color: Colors.red,
                                          )),
                                radius: 40.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          Text(
                            ans,
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 29),
                          ),
                        ],
                      )
                    : Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('No more Questions'),
                            IconButton(
                                onPressed: _resetquiz, icon: Icon(Icons.refresh))
                          ],
                        ),
                    )
              ],
            ),
          ),
        )));
  }
}
