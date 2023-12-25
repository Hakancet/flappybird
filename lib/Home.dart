import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer _audioPlayer = AudioPlayer();
  final AudioCache _audioCache = AudioCache();

  double birdYaxis = 0.5;
  double time = 0;
  double height = 0;
  double initialHeight = 0.5;
  bool gameHasStarted = false;
  double barrierOne = 1;
  double barrierTwo = 1;
  int score = 0;
  int highScore = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadSounds();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _loadSounds() async {
    await _audioCache.load('assets/images/p.mp3');
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    setState(() {
      gameHasStarted = true;
      birdYaxis = 0.5;
      time = 0;
      height = 0;
      initialHeight = birdYaxis;
      barrierOne = 1;
      barrierTwo = 2.5; // İkinci gelen bariyerin arasını açalım.
      score = 0;
    });

    Timer.periodic(
      const Duration(milliseconds: 40),
          (timer) {
        time += 0.05;
        height = -4.9 * time * time + 2.8 * time;
        setState(() {
          birdYaxis = initialHeight - height;

          if (barrierOne < -1.1) {
            barrierOne += 3.6;
            score++;
          } else {
            barrierOne -= 0.02;
          }

          if (barrierTwo < -1.1) {
            barrierTwo += 3.6; // Bariyerler arasındaki mesafeyi azaltmak için 3.6'ya düşürelim.
            score++;
          } else {
            barrierTwo -= 0.02;
          }

          if (birdYaxis > 1) {
            timer.cancel();
            gameHasStarted = false;
            showGameOverDialog();
          }
        });
      },
    );
  }

  void _playDeathSound() async {
    await _audioPlayer.play(Uri.parse('assets/images/p.mp3').toString() as Source);
  }







  void showGameOverDialog() {
    _playDeathSound();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: Text(
            'ÖLDÜN USTAAA ÖLDÜÜN',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'SKOR: $score',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (score > highScore) {
                  highScore = score;
                }
                birdYaxis = 0.5;
                time = 0;
                height = 0;
                initialHeight = birdYaxis;
                barrierOne = 1;
                barrierTwo = 1.5;
                score = 0;
                gameHasStarted = false;
                Navigator.of(context).pop();
              },
              child: Text(
                'TEKRAR OYNA',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(-0.3, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted
                          ? Text(' ')
                          : Text(
                        'UÇ POLAT UÇÇÇ',
                        style:
                        TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * barrierOne,
                      bottom: 0,
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 150,
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * barrierOne,
                      top: 0,
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 200,
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * barrierTwo,
                      bottom: 0,
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 2500),
                        child: Barrier(
                          size: 100,
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * barrierTwo,
                      top: 0,
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 5000),
                        child: Barrier(
                          size: 250,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                ),
              ),
              Container(
                height: 20,
                color: Colors.green,
              ),
              Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SKOR',
                            style: TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            score.toString().padLeft(2, '0'),
                            style: TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'EN İYİ SKOR',
                            style: TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            highScore.toString().padLeft(2, '0'),
                            style: TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset('assets/images/polatpix.png'),
    );
  }
}

class Barrier extends StatelessWidget {
  final double size;

  const Barrier({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          width: 10,
          color: Colors.green[800]!,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
