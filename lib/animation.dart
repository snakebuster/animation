import 'dart:math';

import 'package:flutter/material.dart';

class MyAnimation extends StatefulWidget {
  const MyAnimation({Key? key}) : super(key: key);

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late Animation _scaleAnimation;
  late Animation _rotateAnimation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
        CurvedAnimation(
            parent: _animationController, curve: Interval(0.5, 1.0)));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _rotateAnimation.value,
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepOrange,
          ),
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }
}
