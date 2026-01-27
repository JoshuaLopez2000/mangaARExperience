import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

/// A screen that hosts the Unity AR experience.
///
/// This widget integrates the `flutter_unity_widget` to display a Unity scene.
/// It shows a loading indicator while the Unity scene is being prepared.
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
    // A simple delay to simulate loading and allow Unity to initialize.
    // In a real-world app, this could be tied to a callback from Unity.
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isUnityLoaded = true;
        });
      }
    });
  }

  /// Callback when the Unity widget has been created.
  ///
  /// This function receives the [controller] which is used to communicate
  /// with the Unity scene. It sends a message to Unity's 'SceneManager'
  /// to load the specific AR scene required.
  void onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    _unityWidgetController.postMessage(
      'SceneManager', // GameObject in Unity
      widget.scene, // Method name in a script on the GameObject
      '', // Message payload
    );
  }

  @override
  void dispose() {
    // Before the widget is disposed, send a message to Unity to unload
    // the AR scene and return to an empty scene. This helps manage memory
    // and prevents AR scenes from running in the background.
    _unityWidgetController.postMessage(
      'SceneManager',
      'LoadEmptyScene',
      '',
    );
    _unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(widget.title),
          ),
        ),
      ),
      body: Stack(
        children: [
          // The main Unity widget that renders the AR scene.
          Positioned.fill(
            child: UnityWidget(
              onUnityCreated: onUnityCreated,
              fullscreen: false,
            ),
          ),
          // A loading overlay that is shown until the Unity scene is ready.
          if (!_isUnityLoaded)
            Positioned.fill(
              child: Container(
                color: Colors.black,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 20),
                      Text(
                        'Loading Experience...',
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
