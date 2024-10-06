import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class Screenpaseo extends StatefulWidget {
  const Screenpaseo({super.key, required this.asset});
  final String asset;

  @override
  State<Screenpaseo> createState() => _ScreenpaseoState();
}

class _ScreenpaseoState extends State<Screenpaseo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Panorama en 360 grados
          PanoramaViewer(
            zoom: 1,
            sensorControl: SensorControl.none,
            animReverse: true,
            animSpeed: 2.5,
            child: Image.asset(
              widget.asset,
              fit: BoxFit.cover,
            ),
          ),

          // Botón de "Volver" abajo a la izquierda
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver'),
            ),
          ),
        ],
      ),
    );
  }
}
