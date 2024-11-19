import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:flutter_unity_widget_example/views/chooseVolumeManga/choose_volume_demon_slayer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Widget> imageScreens = {
    'assets/demonSlayer/Kimetsu_no_Yaiba_V1.webp': ChooseVolumeDemonSlayer(),
    'assets/jjk/jjk.jpg': Placeholder(),
    'assets/chainSawMan/chainSawMan01.png': Placeholder(),
  };

  late UnityWidgetController _unityWidgetController;

  void onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    _unityWidgetController.postMessage(
      'SceneManager',
      'LoadEmptyScene',
      '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'MangaFont',
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Builder(
              builder: (BuildContext context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          'Manga AR Experience',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
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
                                    MaterialPageRoute(
                                      builder: (context) => screen,
                                    ),
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
                        height: MediaQuery.of(context).size.height * 0.6,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        animateToClosest: true,
                      ),
                    ),
                  ],
                );
              },
            ),
            // Unity Widget oculto
            Offstage(
              offstage: true,
              child: UnityWidget(
                onUnityCreated: onUnityCreated,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
