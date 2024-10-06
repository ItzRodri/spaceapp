import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceapp/screen/homescreen.dart';
import 'package:spaceapp/screen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'Panets: Explore the Solar System',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const Splashscreen(),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: PanoramaViewer(
            zoom: 1,
            sensorControl: SensorControl.none,
            animReverse: true,
            animSpeed: 2.5,
            child: Image.asset(
              "assets/marte.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Siguiente'))
          ],
        )
      ],
    );
  }
}
