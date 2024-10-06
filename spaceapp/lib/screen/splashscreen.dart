import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:math';
import 'homescreen.dart'; // Asegúrate de importar la pantalla de Homescreen

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20), // Tiempo de rotación lenta
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1), // Duración de la transición
        pageBuilder: (context, animation, secondaryAnimation) => Homescreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          final tween = Tween(begin: begin, end: end);
          final fadeAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff050a23), // Color inicial
              Color(0xff7133C5), // Color final
            ],
          ),
        ),
        child: Stack(
          children: [
            // Fondo de estrellas personalizadas
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarPainter(_controller.value),
                  size: Size(double.infinity, double.infinity),
                );
              },
            ),

            // Planetas rotando
            Positioned(
              top: 0,
              left: 0,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: Opacity(
                      opacity: 0.7,
                      child: Image.asset(
                        'assets/mars.png',
                        width: 50.w,
                        height: 50.w,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 20.h,
              right: 0,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: Opacity(
                      opacity: 0.7,
                      child: Image.asset(
                        'assets/earth.png',
                        width: 50.w,
                        height: 50.w,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Contenido principal
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    child: Text(
                      'Bienvenidos a la Galaxia!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Lottie.asset(
                    'assets/aeronauta.json',
                    width: 40.h,
                    height: 40.h,
                    fit: BoxFit.cover,
                  ),

                  // Botón para navegar con animación
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    child: Center(
                      child: TextButton(
                        onPressed:
                            _navigateToHome, // Navegar con animación suave
                        child: Text(
                          'Viaja con nosotros',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Clase para dibujar las estrellas con animación lenta
class StarPainter extends CustomPainter {
  final Random random = Random();
  final double animationValue;

  StarPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);

    // Dibuja estrellas con animación lenta
    for (int i = 0; i < 20; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() *
          size.height *
          animationValue; // Animar la posición de las estrellas
      final radius = random.nextDouble() *
          2 *
          animationValue; // Animar el tamaño de las estrellas

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Requiere repintar en cada fotograma de la animación
  }
}
