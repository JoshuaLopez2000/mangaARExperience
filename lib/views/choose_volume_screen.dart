import 'package:flutter/material.dart';
import 'package:manga_ar_experience/models/manga.dart';

/// A screen that displays a list of manga volumes for a selected series.
class ChooseVolumeScreen extends StatelessWidget {
  final List<MangaVolume> volumes;

  const ChooseVolumeScreen({Key? key, required this.volumes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(
              'Choose a Volume',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: volumes.length,
        itemBuilder: (context, index) {
          final volume = volumes[index];
          final isAvailable = volume.screen.runtimeType.toString() != 'ComingSoonPlaceholder';

          return VolumeListItem(
            volume: volume,
            volumeNumber: index + 1,
            isAvailable: isAvailable,
          );
        },
      ),
    );
  }
}

/// A widget that represents a single item in the volume list.
class VolumeListItem extends StatelessWidget {
  final MangaVolume volume;
  final int volumeNumber;
  final bool isAvailable;

  const VolumeListItem({
    Key? key,
    required this.volume,
    required this.volumeNumber,
    required this.isAvailable,
  }) : super(key: key);

  static const List<double> _blackAndWhiteFilter = [
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ];

  @override
  Widget build(BuildContext context) {
    Widget leadingImage = Image.asset(volume.imagePath);

    if (!isAvailable) {
      leadingImage = ColorFiltered(
        colorFilter: ColorFilter.matrix(_blackAndWhiteFilter),
        child: leadingImage,
      );
    }

    Widget listItem = ListTile(
      leading: leadingImage,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text('Volume $volumeNumber'),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      onTap: () {
        if (isAvailable) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => volume.screen),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('This volume is not available yet.'),
            ),
          );
        }
      },
    );

    if (!isAvailable) {
      listItem = Banner(
        location: BannerLocation.topEnd,
        message: 'Coming Soon',
        color: Colors.red,
        child: listItem,
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: listItem,
    );
  }
}
