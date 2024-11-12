import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class DemonSlayerUnityScreen extends StatefulWidget {
  @override
  _DemonSlayerUnityScreenState createState() => _DemonSlayerUnityScreenState();
}

class _DemonSlayerUnityScreenState extends State<DemonSlayerUnityScreen> {
  late UnityWidgetController _unityWidgetController;
  bool _isUnityLoaded = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isUnityLoaded = true;
      });
    });
  }

  void onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    _unityWidgetController.postMessage(
      'SceneManager',
      'LoadDemonSlayerV11ARScene',
      '',
    );
  }

  @override
  void dispose() {
    _unityWidgetController.postMessage(
      'SceneManager',
      'LoadEmptyScene',
      '',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demon Slayer AR'),
      ),
      body: Stack(
        children: [
          // Unity Widget
          Positioned.fill(
            child: UnityWidget(
              onUnityCreated: onUnityCreated,
              fullscreen: false,
            ),
          ),
          // Fondo de carga con temporizador
          if (!_isUnityLoaded)
            Positioned.fill(
              child: Container(
                color: Colors.black, // Cambia el color según tu preferencia
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text(
                        'Cargando...',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
