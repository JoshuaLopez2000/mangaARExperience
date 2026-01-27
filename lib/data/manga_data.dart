import 'package:flutter/material.dart';
import 'package:manga_ar_experience/models/manga.dart';
import 'package:manga_ar_experience/views/choose_volume_screen.dart';
import 'package:manga_ar_experience/views/unity_ar_screen.dart';

/// Data for the manga series available in the app.
final List<MangaSeries> mangaSeriesList = [
  MangaSeries(
    title: 'Demon Slayer',
    imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V1.webp',
    screen: ChooseVolumeScreen(volumes: demonSlayerVolumes),
  ),
  MangaSeries(
    title: 'Jujutsu Kaisen',
    imagePath: 'assets/jjk/jjk.jpg',
    screen: ComingSoonPlaceholder(),
  ),
  MangaSeries(
    title: 'Chainsaw Man',
    imagePath: 'assets/chainSawMan/chainSawMan01.png',
    screen: ComingSoonPlaceholder(),
  ),
];

/// Data for the volumes of the "Demon Slayer" manga.
final List<MangaVolume> demonSlayerVolumes = [
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V1.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V2.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V3.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V4.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V5.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V6.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V7.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V8.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V9.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V10.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(
    imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V11.webp',
    screen: UnityARScreen(
      title: 'Demon Slayer V11 AR',
      scene: 'LoadDemonSlayerV11ARScene',
    ),
  ),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V12.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V13.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V14.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V15.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V16.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V17.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V18.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V19.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V20.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V21.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V22.webp', screen: ComingSoonPlaceholder()),
  MangaVolume(imagePath: 'assets/demonSlayer/Kimetsu_no_Yaiba_V23.webp', screen: ComingSoonPlaceholder()),
];

/// A placeholder widget for features that are not yet implemented.
class ComingSoonPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This can be a more complex screen or a simple dialog.
    // For this refactor, we just need a way to identify it.
    return Scaffold(
      appBar: AppBar(title: Text("Coming Soon")),
      body: Center(
        child: Text("This feature is under development."),
      ),
    );
  }
}
