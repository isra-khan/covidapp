import 'dart:async';

import 'package:covidapp/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldStateScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              child: Container(
                width: 200,
                height: 200,
                child: Image.asset("images/virus.png"),
              ),
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                    angle: _controller.value * 2.0 + math.pi, child: child);
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Covid-19\nTracker App",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
