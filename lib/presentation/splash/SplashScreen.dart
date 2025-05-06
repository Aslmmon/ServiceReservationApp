import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:service_reservation_app/utils/appAssets/AppAssets.dart';
import '../../routes/app_navigation.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          repeat: true,
          AppAssets.splashAnimation, // Replace with your animation file path
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().then((_) {
                _controller.repeat();
                Future.delayed(const Duration(seconds: 1), () {
                  AppNavigation.to.handleInitialNavigation();
                });
              });
          },
        ),
      ),
    );
  }
}
