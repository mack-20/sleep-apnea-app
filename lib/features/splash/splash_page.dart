import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sleep_apnea_app/features/profiles/data/profile_storage_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    final hasProfiles = await ProfileStorageService.hasProfiles();

    if (mounted) {
      if (hasProfiles) {
        context.go('/profiles'); // goes to SelectProfilePage
      } else {
        context.go('/create-profile');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Red curved background arc
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              painter: BottomCurvePainter(),
              size: const Size(double.infinity, 300),
            ),
          ),

          // Center content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App icon (replace with your logo asset)
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6159),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.child_care, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  'NeoBreath',
                  style: TextStyle(
                    color: Color(0xFFFF6159),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Orbitron', // optional custom font
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'An infant apnea monitor and\nsupport system',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Footer label
          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'ⓒ Dipper Lab',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF6159)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      size.height * 0.5,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
