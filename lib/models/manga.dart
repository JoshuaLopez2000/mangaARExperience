import 'package:flutter/material.dart';

/// Represents a manga series with its title, cover image, and a list of volumes.
class MangaSeries {
  final String title;
  final String imagePath;
  final Widget screen;

  MangaSeries({
    required this.title,
    required this.imagePath,
    required this.screen,
  });
}

/// Represents a single volume of a manga, with its image and a screen to navigate to.
class MangaVolume {
  final String imagePath;
  final Widget screen;

  MangaVolume({
    required this.imagePath,
    required this.screen,
  });
}
