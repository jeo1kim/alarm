import 'package:flutter/material.dart';

class SunriseAnimation extends StatefulWidget {
  @override
  _SunriseAnimationState createState() => _SunriseAnimationState();
}

class _SunriseAnimationState extends State<SunriseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust the duration as needed
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: SunrisePainter(_animation.value),
          child: child,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

      ),
    );
  }
}

class SunrisePainter extends CustomPainter {
  final double animationValue;

  SunrisePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Color(0xFFFF9B36);
    final sunRadius = 50.0;
    final sunX = size.width / 2;
    final sunY = size.height * (1 - animationValue);

    canvas.drawCircle(Offset(sunX, sunY), sunRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
