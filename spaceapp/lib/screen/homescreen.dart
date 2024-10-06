import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:spaceapp/screen/screenPaseo.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  final List<String> planetImages = [
    'assets/earth.png',
    'assets/mars.png',
    'assets/jupiter.png',
    'assets/saturn.png',
    'assets/mercury.png',
    'assets/neptune.png',
    'assets/venus.png',
    'assets/uranus.png',
  ];
  final List<String> planetKM = [
    '510 millones km²', // Tierra
    '144 millones km²', // Marte
    '61 mil millones km²', // Júpiter
    '42 mil millones km²', // Saturno
    '8 mil millones km²', // Mercurio
    '7.6 mil millones km²', // Neptuno
    '460 millones km²', // Venus
    '74 millones km²', // Urano
  ];

  final List<String> planetV = [
    '107.280 km/h',
    '86.868 km/h ',
    '47.016 km/h',
    '34.705 km/h',
    '172.404 km/h',
    '19.548 km/h',
    '126.108 km/h',
    '24.516 km/h'
  ];
  final List<String> planetSatelites = [
    '1',
    '2',
    '95',
    '146',
    '0',
    '16',
    '0',
    '28'
  ];

  final List<String> planetPaseo = [
    'assets/paseo/tierra.jpeg',
    'assets/paseo/martenoche.jpeg',
    'assets/paseo/jupiter.jpeg',
    'assets/paseo/saturno.jpeg',
    'assets/paseo/mercurio1.jpeg',
    'assets/neptune.png',
    'assets/paseo/venus.jpeg',
    'assets/paseo/urano.jpeg',
  ];

  final List<String> planetNames = [
    'Tierra',
    'Marte',
    'Jupiter',
    'Saturno',
    'Mercurio',
    'Neptuno',
    'Venus',
    'Urano',
  ];

  PageController _pageController = PageController(viewportFraction: 0.6);
  bool _showStack = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    final page = _pageController.page?.round();
    if (page != null && page != _currentPage) {
      setState(() {
        _currentPage = page;
        _showStack = false;
      });

      Future.delayed(Duration(milliseconds: 200), () {
        if (mounted && _pageController.page?.round() == _currentPage) {
          setState(() {
            _showStack = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff050a23),
      body: Stack(
        children: [
          // Fondo de estrellas personalizadas
          CustomPaint(
            painter: StarPainter(),
            size: Size(double.infinity, double.infinity),
          ),

          // Contenido principal
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: planetImages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == planetImages.length) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sol',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Center(
                            child: Lottie.asset(
                              'assets/sun.json',
                              width: 60.w,
                              height: 40.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      );
                    }

                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 0;
                        if (_pageController.position.haveDimensions) {
                          value = index - _pageController.page!;
                          value = (value).clamp(-1, 1);
                        }

                        double angle = value * pi / 1;

                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateZ(angle),
                          child: Opacity(
                            opacity: 1 - value.abs(),
                            child: GestureDetector(
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Screenpaseo(
                                      asset: planetPaseo[index],
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    planetNames[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  SizedBox(
                                    width: 60.w,
                                    height: 30.h,
                                    child: Image.asset(
                                      planetImages[index],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  if (_currentPage == index)
                                    Container(
                                      height: 10.h,
                                    ),
                                  if (_currentPage == index)
                                    Stack(
                                      children: [
                                        AnimatedOpacity(
                                          opacity: _showStack ? 1.0 : 0.0,
                                          duration: Duration(milliseconds: 200),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 60.w,
                                                height: 7.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.05),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/velocidad.svg",
                                                      color: Colors.white,
                                                      width: 6.w,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.w),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Viaja a Una Velocidad',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            planetV[index],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Container(
                                                width: 60.w,
                                                height: 7.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.05),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/satelite.svg",
                                                      color: Colors.white,
                                                      width: 6.w,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Cantidad de Satelites',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          planetSatelites[
                                                              index],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Container(
                                                width: 60.w,
                                                height: 7.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.05),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/rocket.svg",
                                                        color: Colors.white,
                                                        width: 6.w,
                                                      ),
                                                      SizedBox(
                                                        width: 6.w,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Superficie',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            planetKM[index],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Clase para dibujar las estrellas
class StarPainter extends CustomPainter {
  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);

    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
