import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:math';

class CustomSliderWithRiveThumb extends StatefulWidget {
  // final double value;
  // final ValueChanged<double> onChanged;

  const CustomSliderWithRiveThumb({
    Key? key,
    //required this.value,
    //required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSliderWithRiveThumbState createState() =>
      _CustomSliderWithRiveThumbState();
}

class _CustomSliderWithRiveThumbState extends State<CustomSliderWithRiveThumb> {
  double deg2rad(double deg) => deg * pi / 180;
  double posX = 0.0;
  final int breakpoints = 5;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.9;

    final segmentWidth = (maxWidth - 20) /
        (breakpoints - 1); // Calculate the width of each segment

    return Scaffold(
      body: Center(
        child: Container(
          //padding: const EdgeInsets.all(10),
          color: Colors.orange,
          width: maxWidth,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                left: posX,
                //key: const ValueKey("item 1"),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: deg2rad(-(180 + 20) * (posX / maxWidth)),
                    child: RiveAnimation.network(
                      'https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/python.riv',
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      animations: ["idle"],
                      //stateMachines: const ["game"],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onPanEnd: (details) {
                  setState(() {
                    final nearestBreakpoint = (posX / segmentWidth).round();
                    posX = min(nearestBreakpoint * segmentWidth, maxWidth);
                  });
                },
                onPanUpdate: (details) {
                  final newPosX = details.localPosition.dx;
                  // Prevent the draggable area from moving outside the container
                  if (newPosX >= 0 && newPosX <= maxWidth) {
                    setState(() {
                      posX = newPosX;
                    });
                  }

                  if (posX / maxWidth > 1) {
                    print(posX / maxWidth);
                    // final nearestBreakpoint = (posX / segmentWidth).round();
                    // posX = min(nearestBreakpoint * segmentWidth,
                    //     maxWidth); // Trigger success action if dragged to the end
                  }
                },
              ),
              Positioned(
                //top: , // Distance from the top
                left: 25 - 10, // Distance from the right
                child: Container(color: Colors.red, width: 20, height: 20),
              ),
              Positioned(
                //top: , // Distance from the top
                left: segmentWidth + 25 - 10, // Distance from the right
                child: Container(color: Colors.red, width: 20, height: 20),
              ),
              Positioned(
                //top: , // Distance from the top
                left: (segmentWidth * 2) + 25 - 10, // Distance from the right
                child: Container(color: Colors.red, width: 20, height: 20),
              ),
              Positioned(
                //top: , // Distance from the top
                left: (segmentWidth * 3) + 25 - 10, // Distance from the right
                child: Container(color: Colors.red, width: 20, height: 20),
              ),
              Positioned(
                //top: , // Distance from the top
                left: (segmentWidth * 4) + 25 - 10, // Distance from the right
                child: Container(color: Colors.red, width: 20, height: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
