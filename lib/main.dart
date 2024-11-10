import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/demon_slayer_unity_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, Widget> imageScreens = {
    'lib/assets/demonSlayer/demonSlayer01.jpg': DemonSlayerUnityScreen(),
    'lib/assets/jjk/jjk.jpg': ScreenTwo(),
    'lib/assets/chainSawMan/chainSawMan01.png': ScreenThree(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Manga AR Experience',
                  style: TextStyle(),
                ),
                CarouselSlider(
                  items: imageScreens.entries.map((entry) {
                    String imageUrl = entry.key;
                    Widget screen = entry.value;
                    return imageUrl != imageScreens.keys.first
                        ? GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Seguimos trabajando para traerte este manga en AR',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              child: Center(
                                child: Banner(
                                  message: "Proximamente",
                                  location: BannerLocation.topEnd,
                                  color: Colors.red,
                                  child: Image.asset(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: 1000,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => screen),
                              );
                            },
                            child: Container(
                              child: Center(
                                child: Image.asset(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: 1000,
                                ),
                              ),
                            ),
                          );
                  }).toList(),
                  options: CarouselOptions(
                    height: 600,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    animateToClosest: true,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Pantallas individuales como StatefulWidgets

class ScreenOne extends StatefulWidget {
  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen One")),
      body: Center(child: Text("This is Screen One")),
    );
  }
}

class ScreenTwo extends StatefulWidget {
  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen Two")),
      body: Center(child: Text("This is Screen Two")),
    );
  }
}

class ScreenThree extends StatefulWidget {
  @override
  _ScreenThreeState createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen Three")),
      body: Center(child: Text("This is Screen Three")),
    );
  }
}

class ScreenFour extends StatefulWidget {
  @override
  _ScreenFourState createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen Four")),
      body: Center(child: Text("This is Screen Four")),
    );
  }
}

class ScreenFive extends StatefulWidget {
  @override
  _ScreenFiveState createState() => _ScreenFiveState();
}

class _ScreenFiveState extends State<ScreenFive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen Five")),
      body: Center(child: Text("This is Screen Five")),
    );
  }
}

class ScreenSix extends StatefulWidget {
  @override
  _ScreenSixState createState() => _ScreenSixState();
}

class _ScreenSixState extends State<ScreenSix> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen Six")),
      body: Center(child: Text("This is Screen Six")),
    );
  }
}
