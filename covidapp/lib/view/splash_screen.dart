import 'package:covidapp/constant/assets.dart';
import 'package:covidapp/constant/responsive_config.dart';
import 'package:covidapp/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final SplashController _stateServicesController =
      Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildSplashContent(context),
    );
  }

  ///  Splash screen main content
  Widget _buildSplashContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildRotatingVirus(),
        SizedBox(height: Responsive(context).height * 0.2),
        _buildTitleText(),
      ],
    );
  }

  /// 🦠 Rotating virus image
  Widget _buildRotatingVirus() {
    return AnimatedBuilder(
      animation: _stateServicesController,
      child: SizedBox(
        width: 200,
        height: 200,
        child: Image.asset(Assets().virus),
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _stateServicesController.controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }

  ///  Title text
  Widget _buildTitleText() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "Covid-19\nTracker App",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 25,
        ),
      ),
    );
  }
}
