import 'package:flutter/material.dart';

import 'demon_slayer_unity_screen.dart';

class ChooseVolumeDemonSlayer extends StatelessWidget {
  final List<Map<String, dynamic>> volumes = [
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V1.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V2.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V3.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V4.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V5.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V6.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V7.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V8.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V9.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V10.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V11.webp',
      'screen': DemonSlayerUnityScreen(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V12.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V13.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V14.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V15.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V16.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V17.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V18.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V19.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V20.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V21.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V22.webp',
      'screen': Placeholder(),
    },
    {
      'image': 'assets/demonSlayer/Kimetsu_no_Yaiba_V23.webp',
      'screen': Placeholder(),
    },
  ];

  final List<double> blackAndWhiteImage = [
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Volume'),
      ),
      body: ListView.builder(
        itemCount: volumes.length,
        itemBuilder: (context, index) {
          return volumes[index]['screen'] is Placeholder
              ? Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: Banner(
                    location: BannerLocation.topEnd,
                    message: 'Proximamente',
                    child: ListTile(
                      leading: ColorFiltered(
                        colorFilter: ColorFilter.matrix(
                          blackAndWhiteImage,
                        ),
                        child: Image.asset(
                          volumes[index]['image'],
                        ),
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          'Volume ${index + 1}',
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Este volumen no está disponible'),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: ListTile(
                    leading: Image.asset(volumes[index]['image']),
                    title: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Volume ${index + 1}',
                      ),
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => volumes[index]['screen'],
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
