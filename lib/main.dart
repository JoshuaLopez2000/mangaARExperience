import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:manga_ar_experience/data/manga_data.dart';
import 'package:manga_ar_experience/models/manga.dart';

void main() {
  runApp(const MangaARExperienceApp());
}

/// The main entry point of the application.
class MangaARExperienceApp extends StatelessWidget {
  const MangaARExperienceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manga AR Experience',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'MangaFont',
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

/// The home screen, which displays a carousel of manga series.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // This widget preloads the Unity view in the background to make
          // the transition to the AR screen faster.
          const Offstage(
            offstage: true,
            child: UnityPreloader(),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppTitle(),
                const SizedBox(height: 20),
                MangaCarousel(seriesList: mangaSeriesList),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget that displays the main title of the app.
class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Text(
          'Manga AR Experience',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}

/// A carousel widget that displays manga series covers.
class MangaCarousel extends StatelessWidget {
  final List<MangaSeries> seriesList;

  const MangaCarousel({Key? key, required this.seriesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: seriesList.map((series) {
        final bool isAvailable = series.screen.runtimeType.toString() != 'ComingSoonPlaceholder';
        return MangaCarouselItem(
          series: series,
          isAvailable: isAvailable,
        );
      }).toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.6,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        animateToClosest: true,
      ),
    );
  }
}

/// A single item in the manga carousel.
class MangaCarouselItem extends StatelessWidget {
  final MangaSeries series;
  final bool isAvailable;

  const MangaCarouselItem({
    Key? key,
    required this.series,
    required this.isAvailable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(series.imagePath, fit: BoxFit.cover, width: 1000);

    if (!isAvailable) {
      image = Banner(
        message: "Coming Soon",
        location: BannerLocation.topEnd,
        color: Colors.red,
        child: image,
      );
    }

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => series.screen),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('We are working to bring this manga to AR soon!'),
            ),
          );
        }
      },
      child: Center(child: image),
    );
  }
}


/// A hidden widget used to preload the Unity scene.
class UnityPreloader extends StatefulWidget {
  const UnityPreloader({Key? key}) : super(key: key);

  @override
  _UnityPreloaderState createState() => _UnityPreloaderState();
}

class _UnityPreloaderState extends State<UnityPreloader> {
  late UnityWidgetController _unityWidgetController;

  @override
  void dispose() {
    _unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnityWidget(
      onUnityCreated: (controller) {
        _unityWidgetController = controller;
        // Load an empty scene in Unity to initialize it.
        _unityWidgetController.postMessage(
          'SceneManager',
          'LoadEmptyScene',
          '',
        );
      },
    );
  }
}
