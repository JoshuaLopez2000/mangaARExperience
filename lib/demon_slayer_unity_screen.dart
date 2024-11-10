import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class DemonSlayerUnityScreen extends StatefulWidget {
  @override
  _DemonSlayerUnityScreenState createState() => _DemonSlayerUnityScreenState();
}

class _DemonSlayerUnityScreenState extends State<DemonSlayerUnityScreen> {
  late UnityWidgetController _unityWidgetController;

  // Callback para cuando el controlador de Unity esté inicializado
  void onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
  }

  // Método para enviar mensajes a Unity
  void sendMessageToUnity() {
    _unityWidgetController.postMessage(
      'GameObjectName', // Nombre del objeto en Unity
      'MethodName', // Nombre del método en Unity
      'Message from Flutter', // Mensaje a Unity
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Unity Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: UnityWidget(
              onUnityCreated: onUnityCreated,
              fullscreen: false,
            ),
          ),
          ElevatedButton(
            onPressed: sendMessageToUnity,
            child: Text('Send Message to Unity'),
          ),
        ],
      ),
    );
  }
}
