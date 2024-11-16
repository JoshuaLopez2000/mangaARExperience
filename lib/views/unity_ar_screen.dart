import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityARScreen extends StatefulWidget {
  final String title;
  final String scene;

  const UnityARScreen({
    Key? key,
    required this.title,
    required this.scene,
  }) : super(key: key);

  @override
  _UnityARScreenState createState() => _UnityARScreenState();
}

class _UnityARScreenState extends State<UnityARScreen> {
  late UnityWidgetController _unityWidgetController;
  bool _isUnityLoaded = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isUnityLoaded = true;
      });
    });
  }

  void onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    _unityWidgetController.postMessage(
      'SceneManager',
      widget.scene,
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
        title: Text(widget.title),
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
          if (!_isUnityLoaded)
            Positioned.fill(
              child: Container(
                color: Colors.black,
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
